import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_menu_flutter/src/models/item_category.dart';
import 'package:web_menu_flutter/src/models/models.dart';

class RestaurantRepository {
  final CollectionReference _restaurantsCollection =
      FirebaseFirestore.instance.collection('restaurants');

  Future<List<Restaurant>> getRestaurants({String? searchEntry}) async {
    final QuerySnapshot snapshot = await _restaurantsCollection.get();
    return snapshot.docs
        .map((QueryDocumentSnapshot d) => Restaurant.fromJson(d.data(), d.id))
        .toList();
  }

  Future<List<ItemCategory>> getRestaurantMenu(
      String id, List<dynamic> menuTemplate) async {
    final QuerySnapshot snapshot =
        await _restaurantsCollection.doc(id).collection('menu-items').get();
    final List<ItemCategory> menu = <ItemCategory>[];
    for (dynamic category in menuTemplate) {
      final List<MenuItem> categoryItems = <MenuItem>[];
      for (DocumentReference itemRef in category['items']) {
        for (QueryDocumentSnapshot doc in snapshot.docs) {
          if (doc.reference.id == itemRef.id) {
            categoryItems.add(MenuItem.fromJson(doc.data()));
            break;
          }
        }
      }
      menu.add(ItemCategory(category['category'], categoryItems));
    }

    return menu;
  }

  Future<Restaurant> getRestaurant(String id) async {
    final DocumentSnapshot snapshot =
        await _restaurantsCollection.doc(id).get();
    final List<ItemCategory> menu =
        await getRestaurantMenu(id, snapshot.get('menu'));
    return Restaurant.fromJson(snapshot.data(), snapshot.id, menu);
  }
}
