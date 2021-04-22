import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:meta/meta.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final NetworkInfoImpl networkInfo;
  final MovieRepoImpl movieRepo;
  List<MovieEntity> moviesList;

  MovieBloc({
    @required this.networkInfo,
    @required this.movieRepo,
  }) : super(MovieInitialState());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is MovieGetMoviesEvent) {
      bool hasInternetConnection = await networkInfo.isConnected;
      if (hasInternetConnection) {
        yield MovieLoadingState();
        try {
          print('Searching: ${event.searchString}');

          moviesList = await movieRepo.getMovieListOnline(event.searchString);

          print(moviesList);
          yield MovieLoadedSuccessfulState(moviesList);
        } catch (e) {
          print(e);
          yield MovieErrorState();
        }
      } else {
        yield MovieErrorState();
      }
    } else if (event is MovieShowDetailEvent) {
      yield MovieShowDetailState(event.movie);
    } else if (event is MovieGoBackEvent) {
      yield MovieLoadedSuccessfulState(moviesList);
    } else {
      yield MovieErrorState();
    }
  }
}
