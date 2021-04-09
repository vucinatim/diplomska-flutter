import 'package:equatable/equatable.dart';

class User extends Equatable {
  /// {@macro user}
  const User({
    required this.email,
    required this.id,
    this.name,
    this.photo,
  });

  /// The current user's email address.
  final String email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const User empty = User(email: '', id: '', name: null, photo: null);

  @override
  List<Object?> get props => <Object?>[email, id, name, photo];
}
