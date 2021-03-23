part of 'restaurants_bloc.dart';

@immutable
abstract class RestaurantsEvent extends Equatable {
  const RestaurantsEvent();
  @override
  List<Object> get props => const <Object>[];
}

class LoadRestaurants extends RestaurantsEvent {
  @override
  String toString() => 'LoadRestaurants';
}

class SearchRestaurants extends RestaurantsEvent {
  const SearchRestaurants(this.searchEntry);

  final String searchEntry;

  @override
  List<Object> get props => <Object>[searchEntry];
}
