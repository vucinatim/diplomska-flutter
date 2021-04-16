part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
  @override
  List<Object?> get props => const <Object>[];
}

class LoadRestaurant extends RestaurantEvent {
  const LoadRestaurant(this.id);

  final String id;

  @override
  List<Object?> get props => <Object?>[id];
}
