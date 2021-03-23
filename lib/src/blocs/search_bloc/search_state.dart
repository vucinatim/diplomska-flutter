part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => const <Object>[];
}

class WaitingForInput extends SearchState {
  @override
  String toString() => 'WaitingForInput';
}

class SearchInProgress extends SearchState {
  @override
  String toString() => 'SearchInProgress';
}

class SearchFinished<T> extends SearchState {
  const SearchFinished({
    required this.results,
  });

  final List<T> results;

  @override
  List<Object> get props => <Object>[results];
}

class SearchFailed extends SearchState {
  const SearchFailed({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
