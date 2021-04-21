import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc() : super(MovieSearchInitial());

  @override
  Stream<MovieSearchState> mapEventToState(
    MovieSearchEvent event,
  ) async* {
    if (event is MovieSearchGetInputEvent) {
      yield MovieSearchGetInputState();
    } else if (event is MovieSearchTerminatingEvent) {
      yield MovieSearchTerminatingState();
    }
  }
}
