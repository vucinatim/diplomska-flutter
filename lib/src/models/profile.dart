import 'models.dart';

class Profile {
  final String? id;
  final String? fullName;
  final String? email;
  final List<Restaurant>? favourites;

  Profile({this.id, this.fullName, this.email, this.favourites});

  Profile.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        favourites = data['favourites'];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'favourites': favourites?.map((Restaurant e) => e.id).toList(),
    };
  }
}
