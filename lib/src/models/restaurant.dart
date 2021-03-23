import 'dart:convert';

import 'models.dart';

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final ContactInfo? contactInfo;
  final List<String>? supportedLanguages;
  final List<ItemCategory>? menu;
  final MenuConfig? config;
  final Map<String, String>? openingHours;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.contactInfo,
    this.supportedLanguages,
    this.menu,
    this.config,
    this.openingHours,
  });

  Restaurant copyWith({
    final String? id,
    final String? name,
    final String? description,
    final String? imageUrl,
    final ContactInfo? contactInfo,
    final List<String>? supportedLanguages,
    final List<ItemCategory>? menu,
    final MenuConfig? config,
    final Map<String, String>? openingHours,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      contactInfo: contactInfo ?? this.contactInfo,
      supportedLanguages: supportedLanguages ?? this.supportedLanguages,
      menu: menu ?? this.menu,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  Restaurant.fromJson(Map<String, dynamic> data, this.id, this.menu)
      : name = data['name'],
        description = data['description'],
        imageUrl = data['imageUrl'],
        contactInfo = ContactInfo.fromJson(data['contactInfo']),
        supportedLanguages = data['supportedLanguages'],
        config = MenuConfig.fromJson(data['config']),
        openingHours = data['openingHours'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'contactInfo': contactInfo!.toJson(),
      'openingHours': json.encode(openingHours)
    };
  }
}
