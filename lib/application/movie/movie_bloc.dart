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
  List<MovieEntity> _moviesList;

  MovieBloc({
    @required this.networkBloc,
    @required this.movieRepo,
  }) : super(MovieInitialState());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is MovieGetMoviesEvent) {
      bool hasInternetConnection = await networkBloc.isConnectedToInternet();
      if (hasInternetConnection) {
        yield MovieLoadingState();
        try {
          _moviesList = await movieRepo.getMovieListOnline(event.searchString);
          print(_moviesList);
          yield MovieLoadedSuccessfulState(_moviesList);
        } catch (e) {
          print('Yea I did this');
          print(e);
          yield MovieErrorState();
        }
      } else {
        yield MovieErrorState();
      }
    }
  }
}
