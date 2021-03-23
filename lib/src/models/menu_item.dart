import 'models.dart';

class MenuItem {
  Map<String, String>? title;
  Map<String, String>? description;
  String? imageUrl;
  String? amount;
  double? price;
  MenuItemDetails? details;
  MenuItemMetadata? metadata;

  MenuItem({
    this.title,
    this.description,
    this.imageUrl,
    this.amount,
    this.price,
    this.details,
    this.metadata,
  });

  MenuItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    amount = json['amount'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'amount': amount,
      'price': price,
    };
  }
}
