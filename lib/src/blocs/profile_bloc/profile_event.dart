part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => const <Object>[];
}

class LoadProfile extends ProfileEvent {
  @override
  String toString() => 'LoadProfile';
}
