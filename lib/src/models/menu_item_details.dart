class MenuItemDetails {
  Map<String, List<String>>? allergens;
  Map<String, List<String>>? ingredients;

  MenuItemDetails({
    this.allergens,
    this.ingredients,
  });

  MenuItemDetails.fromJson(Map<String, dynamic> data) {
    allergens = data['allergens'];
    ingredients = data['ingredients'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'allergens': allergens,
      'ingredients': ingredients,
    };
  }
}
