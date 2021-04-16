import 'models.dart';

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? thumbnail;
  final String? headerImg;
  final ContactInfo? contactInfo;
  final List<dynamic>? menuTemplate;
  final List<ItemCategory>? menu;
  final Map<String, OpenHours>? openingHours;

  const Restaurant({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.headerImg,
    this.contactInfo,
    this.menu,
    this.menuTemplate,
    this.openingHours,
  });

  Restaurant copyWith({
    final String? id,
    final String? name,
    final String? description,
    final String? thumbnail,
    final String? headerImg,
    final ContactInfo? contactInfo,
    final List<ItemCategory>? menu,
    final List<Map<String, dynamic>>? menuTemplate,
    final Map<String, OpenHours>? openingHours,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      headerImg: headerImg ?? this.headerImg,
      contactInfo: contactInfo ?? this.contactInfo,
      menu: menu ?? this.menu,
      menuTemplate: menuTemplate ?? this.menuTemplate,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  factory Restaurant.fromJson(Map<String, dynamic>? json, String id,
      [List<ItemCategory>? menu]) {
    return Restaurant(
      id: id,
      name: json?['name'],
      description: json?['description'],
      thumbnail: json?['thumbnail'],
      headerImg: json?['header_img'],
      contactInfo: ContactInfo.fromJson(json?['contact_info']),
      openingHours: getOpeningHours(json?['open_hours']),
      menuTemplate: json?['menu'],
      menu: menu,
    );
  }
}

Map<String, OpenHours> getOpeningHours(Map<String, dynamic>? jsonHours) {
  final Map<String, OpenHours> openingHours = <String, OpenHours>{};
  jsonHours?.forEach((String key, dynamic value) {
    openingHours[key] = OpenHours.fromJson(value);
  });
  return openingHours;
}
