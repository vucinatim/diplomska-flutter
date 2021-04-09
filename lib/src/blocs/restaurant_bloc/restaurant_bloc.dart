import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/repositories/restaurant_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc({required RestaurantRepository restaurantRepository})
      : _restaurantRepository = restaurantRepository,
        super(const RestaurantNotLoaded());

  final RestaurantRepository _restaurantRepository;

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is LoadRestaurant) {
      yield* _mapLoadRestaurantToState(event);
    }
  }

  /// LOAD Restaurant
  Stream<RestaurantState> _mapLoadRestaurantToState(
      LoadRestaurant event) async* {
    yield RestaurantLoading();
    try {
      final Restaurant restaurant =
          await _restaurantRepository.getRestaurant(event.id);
      yield RestaurantLoaded(restaurant: restaurant);
    } catch (e) {
      yield RestaurantNotLoaded(message: e.toString());
    }
  }
}
