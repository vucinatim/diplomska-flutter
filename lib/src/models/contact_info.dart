import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  double? lat;
  double? lng;

  Location({
    required this.lat,
    required this.lng,
  });

  Location.fromGeoPoint(GeoPoint? data) {
    if (data == null) {
      return;
    }

    lat = data.latitude;
    lng = data.longitude;
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
    location = Location.fromGeoPoint(data['location']);
  }
}
