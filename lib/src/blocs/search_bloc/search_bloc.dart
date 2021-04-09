import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc<T> extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.items, required this.filter})
      : super(WaitingForInput());

  final List<T> items;
  final bool Function(T, String) filter;

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is Search) {
      yield* _mapSearchToState(event);
    }
  }

  Stream<SearchState> _mapSearchToState(Search event) async* {
    yield SearchInProgress();
    try {
      final List<T> results =
          items.where((T item) => filter(item, event.query)).toList();
      yield SearchFinished<T>(results: results);
    } catch (e) {
      yield SearchFailed(message: e.toString());
    }
  }
}
