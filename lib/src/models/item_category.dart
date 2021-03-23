import 'menu_item.dart';

class ItemCategory {
  Map<String, String>? title;
  Map<String, String>? description;
  List<MenuItem>? items;

  ItemCategory({
    this.title,
    this.description,
    this.items,
  });

  ItemCategory.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    description = data['description'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }
}
