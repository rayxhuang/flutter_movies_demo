import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final NetworkBloc networkBloc;

  MovieBloc({this.networkBloc}) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (await networkBloc.isConnected()) {
      yield MovieLoading();

      yield MovieLoaded();
    } else {
      yield MovieError();
    }
  }
}
