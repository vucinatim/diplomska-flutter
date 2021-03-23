import 'models.dart';

class Menu {
  String? id;
  String? title;
  String? description;
  String? imageUrl;
  List<String>? supportedLanguages;
  MenuConfig? config;
  List<ItemCategory>? categories;

  Menu({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.supportedLanguages,
    this.config,
    this.categories,
  });

  Menu.fromJson(Map<String, dynamic> json, String id) {
    id = id;
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    supportedLanguages = json['supported_languages'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'supported_languages': supportedLanguages,
      'imageUrl': imageUrl,
      'config': config,
    };
  }
}

//const menuContentExample = {
//  'drinks': [
//    {
//      'name': 'Espresso',
//      'price': 1.80,
//      'description': 'Small amount of black coffee',
//    },
//    {
//      'name': 'Beer Union',
//      'price': 2.80,
//    },
//  ],
//  'food': [
//    {
//      'name': 'Burger Krpan',
//      'price': 6.80,
//      'allergens': ['gluten', 'lactose'],
//    },
//    {
//      'name': 'Burger Classic',
//      'price': 6.20,
//      'allergens': ['gluten', 'lactose'],
//    },
//  ],
//  'other': [
//    {
//      'name': 'Marlboro Red',
//      'price': 4.20,
//    },
//    {
//      'name': 'Marlboro Touch 6',
//      'price': 3.80,
//      'allergens': ['cancer'],
//    },
//  ]
//};
