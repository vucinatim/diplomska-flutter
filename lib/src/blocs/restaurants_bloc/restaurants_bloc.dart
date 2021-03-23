import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_menu_flutter/src/models/models.dart';
import 'package:web_menu_flutter/src/repositories/restaurant_repository.dart';

part 'restaurants_event.dart';
part 'restaurants_state.dart';

class RestaurantsBloc extends Bloc<RestaurantsEvent, RestaurantsState> {
  RestaurantsBloc({required RestaurantRepository restaurantRepository})
      : assert(restaurantRepository != null),
        _restaurantRepository = restaurantRepository,
        super(const RestaurantsNotLoaded());

  final RestaurantRepository _restaurantRepository;

  @override
  Stream<RestaurantsState> mapEventToState(RestaurantsEvent event) async* {
    if (event is LoadRestaurants) {
      yield* _mapLoadRestaurantsToState();
    } else if (event is SearchRestaurants) {
      yield* _mapSearchRestaurantsToState(event);
    }
  }

  /// LOAD Restaurants
  Stream<RestaurantsState> _mapLoadRestaurantsToState() async* {
    yield RestaurantsLoading();
    try {
      final List<Restaurant> restaurants =
          await _restaurantRepository.getRestaurants();
      yield RestaurantsLoaded(restaurants: restaurants);
    } catch (e) {
      yield RestaurantsNotLoaded(message: e.toString());
    }
  }

  /// LOAD Restaurants
  Stream<RestaurantsState> _mapSearchRestaurantsToState(
      SearchRestaurants event) async* {
    yield RestaurantsLoading();
    try {
      final List<Restaurant> restaurants = await _restaurantRepository
          .getRestaurants(searchEntry: event.searchEntry);
      if (restaurants.isNotEmpty)
        yield RestaurantsLoaded(restaurants: restaurants);
      else
        yield const RestaurantsNotLoaded();
    } catch (e) {
      yield RestaurantsNotLoaded(message: e.toString());
    }
  }
}
