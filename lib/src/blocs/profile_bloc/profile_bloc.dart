import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
      {required ProfileRepository profileRepository,
      required AuthenticationRepository authenticationRepository})
      : _profileRepository = profileRepository,
        _authenticationRepository = authenticationRepository,
        super(const ProfileNotLoaded()) {
    _userSubscription = _authenticationRepository.user.listen(
      (User user) => user != User.empty ? add(LoadProfile(user)) : null,
    );
  }

  final ProfileRepository _profileRepository;
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User>? _userSubscription;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState(event);
    } else if (event is ToggleFavorite) {
      yield* _mapAddFavoriteToState(state, event);
    }
  }

  /// LOAD Profile
  Stream<ProfileState> _mapLoadProfileToState(LoadProfile event) async* {
    yield ProfileLoading();
    try {
      final Profile profile = await _profileRepository.getProfile(event.user);
      yield ProfileLoaded(profile: profile);
    } catch (e) {
      yield ProfileNotLoaded(message: e.toString());
    }
  }

  /// TOGGLE Favorite
  Stream<ProfileState> _mapAddFavoriteToState(
      ProfileState state, ToggleFavorite event) async* {
    if (state is ProfileLoaded) {
      // yield ProfileLoading();
      try {
        Profile updatedProfile;
        if (state.profile.favorites
            .map((Restaurant r) => r.id)
            .contains(event.favorite.id)) {
          /// Remove existing favorite restaurant
          final List<Restaurant> newFavorites = state.profile.favorites;
          newFavorites.removeWhere(
              (Restaurant element) => element.id == event.favorite.id);
          updatedProfile = Profile(
            user: state.profile.user,
            favorites: newFavorites,
          );
        } else {
          /// Add new favorite restaurant
          updatedProfile = Profile(
              user: state.profile.user,
              favorites: <Restaurant>[
                ...state.profile.favorites,
                event.favorite
              ]);
        }
        await _profileRepository.updateProfile(updatedProfile);
        yield ProfileLoaded(profile: updatedProfile);
      } catch (e) {
        yield ProfileNotLoaded(message: e.toString());
      }
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
