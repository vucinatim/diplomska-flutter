part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => const <Object>[];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile(this.user);

  final User user;

  @override
  String toString() => 'LoadProfile';

  @override
  List<Object> get props => <Object>[user];
}

class ToggleFavorite extends ProfileEvent {
  const ToggleFavorite(this.favorite);

  final Restaurant favorite;

  @override
  String toString() => '<3 ${favorite.name}';

  @override
  List<Object> get props => <Object>[favorite];
}
