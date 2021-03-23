part of 'restaurants_bloc.dart';

@immutable
abstract class RestaurantsState extends Equatable {
  const RestaurantsState();
  @override
  List<Object?> get props => const <Object>[];
}

class RestaurantsLoading extends RestaurantsState {
  @override
  String toString() => 'RestaurantsLoading';
}

class RestaurantsNotLoaded extends RestaurantsState {
  const RestaurantsNotLoaded({
    this.message,
  });

  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}

class RestaurantsLoaded extends RestaurantsState {
  const RestaurantsLoaded({
    required this.restaurants,
  });

  final List<Restaurant> restaurants;

  @override
  List<Object> get props => <Object>[restaurants];
}
