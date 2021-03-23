part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => const <Object>[];
}

class Search extends SearchEvent {
  const Search(this.query);

  final String query;

  @override
  List<Object> get props => <Object>[query];
}
