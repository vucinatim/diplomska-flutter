class MenuConfig {
  Map<String, String>? colors;

  MenuConfig({
    this.colors,
  });

  MenuConfig.fromJson(Map<String, dynamic> data) {
    colors = data['colors'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'colors': colors,
    };
  }
}
