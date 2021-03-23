import 'models.dart';

class User {
  final String? id;
  final String? fullName;
  final String? companyName;
  final String? email;
  final List<Restaurant>? restaurants;

  User(
      {this.id, this.fullName, this.companyName, this.email, this.restaurants});

  User.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        companyName = data['companyName'],
        email = data['email'],
        restaurants = data['restaurants'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'companyName': companyName,
      'email': email,
      'restaurants': restaurants,
    };
  }
}
