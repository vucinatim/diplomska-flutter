import 'models.dart';

class Profile {
  final User user;
  late final List<Restaurant> favorites;

  Profile({required this.user, List<Restaurant>? favorites}) {
    this.favorites = favorites ?? <Restaurant>[];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'favorites': favorites.map((Restaurant e) => e.id).toList(),
    };
  }
}
