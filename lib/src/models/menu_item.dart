class MenuItem {
  String? name;
  String? description;
  String? image;
  double? price;

  MenuItem({
    this.name,
    this.description,
    this.image,
    this.price,
  });

  MenuItem.fromJson(Map<String, dynamic>? json) {
    name = json?['name'];
    description = json?['description'];
    image = json?['image'];
    price = json?['price'];
  }
}
