import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final NetworkBloc networkBloc;
  final MovieRepoImpl movieRepo;
  List<Movie> _movies;

  MovieBloc({
    @required this.networkBloc,
    @required this.movieRepo,
  }) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is GetMovies) {
      bool hasInternetConnection = await networkBloc.isConnected();
      if (hasInternetConnection) {
        yield MovieLoading();
        try {
          _movies = await movieRepo.getMovies(event.search);
          print(_movies);
          yield MovieLoaded();
        } catch (e) {
          print(e);
          yield MovieError();
        }
      } else {
        yield MovieError();
      }
    }
  }
}
