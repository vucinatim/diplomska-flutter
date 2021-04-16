import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_menu_flutter/src/models/models.dart';

class ProfileRepository {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference _restaurantsCollection =
      FirebaseFirestore.instance.collection('restaurants');

  Future<Profile> getProfile(User user) async {
    final DocumentSnapshot profileSnap =
        await _usersCollection.doc(user.id).get();
    final List<dynamic>? favoriteIds = profileSnap.get('favorites');
    if (favoriteIds == null || favoriteIds.isEmpty) {
      return Profile(user: user);
    }
    final QuerySnapshot favoritesSnap = await _restaurantsCollection
        .where(FieldPath.documentId, whereIn: profileSnap.get('favorites'))
        .get();
    return Profile(
      user: user,
      favorites: favoritesSnap.docs
          .map((QueryDocumentSnapshot e) => Restaurant.fromJson(e.data(), e.id))
          .toList(),
    );
  }

  Future<void> updateProfile(Profile profile) async {
    await _usersCollection.doc(profile.user.id).set(profile.toJson());
  }
}
