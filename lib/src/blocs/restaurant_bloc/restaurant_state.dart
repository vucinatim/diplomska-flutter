part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {
  const RestaurantState();
  @override
  List<Object?> get props => const <Object>[];
}

class RestaurantLoading extends RestaurantState {
  @override
  String toString() => 'RestaurantLoading';
}

class RestaurantNotLoaded extends RestaurantState {
  const RestaurantNotLoaded({
    this.message,
  });

  final String? message;

  @override
  List<Object?> get props => <Object?>[message];
}

class RestaurantLoaded extends RestaurantState {
  const RestaurantLoaded({
    required this.restaurant,
  });

  final Restaurant restaurant;

  @override
  List<Object> get props => <Object>[restaurant];
}
