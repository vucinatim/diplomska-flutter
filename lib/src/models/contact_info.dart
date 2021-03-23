class Location {
  double? lat;
  double? lng;

  Location({
    required this.lat,
    required this.lng,
  });

  Location.fromJson(Map<String, dynamic> data) {
    lat = data['latitude'] ?? 0;
    lng = data['longitude'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'latitude': lat,
      'longitude': lng,
    };
  }
}

class ContactInfo {
  String? address;
  String? city;
  String? email;
  String? phone;
  String? postNumber;
  String? website;
  Location? location;

  ContactInfo({
    this.address,
    this.city,
    this.email,
    this.phone,
    this.postNumber,
    this.website,
    this.location,
  });

  ContactInfo.fromJson(Map<String, dynamic> data) {
    address = data['address'];
    city = data['city'];
    email = data['email'];
    phone = data['phone'];
    postNumber = data['post_number'];
    website = data['website'];
    location = Location.fromJson(data['location']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'email': email,
      'phone': phone,
      'post_number': postNumber,
      'website': website,
      'location': location?.toJson(),
    };
  }
}
