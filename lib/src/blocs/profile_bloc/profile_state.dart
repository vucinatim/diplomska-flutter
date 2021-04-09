part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => const <Object>[];
}

class ProfileLoading extends ProfileState {
  @override
  String toString() => 'ProfileLoading';
}

class ProfileNotLoaded extends ProfileState {
  const ProfileNotLoaded({
    this.message,
  });

  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.profile,
  });

  final Profile profile;

  @override
  List<Object> get props => <Object>[profile];
}
