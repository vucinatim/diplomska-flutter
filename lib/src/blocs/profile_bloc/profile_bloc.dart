import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/repositories/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository,
        super(const ProfileNotLoaded());

  final ProfileRepository _profileRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    }
  }

  /// LOAD Profile
  Stream<ProfileState> _mapLoadProfileToState() async* {
    yield ProfileLoading();
    try {
      final Profile profile = await _profileRepository.getProfile();
      yield ProfileLoaded(profile: profile);
    } catch (e) {
      yield ProfileNotLoaded(message: e.toString());
    }
  }
}
