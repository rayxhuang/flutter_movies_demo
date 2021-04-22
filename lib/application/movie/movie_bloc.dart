import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_app_demo/domain/movie/imdb_id.dart';
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

          //_moviesList = await movieRepo.getMovieListOnline(event.searchString);

          final MovieEntity test = MovieEntity(
              id: ImdbID(id: 'tt0944947'),
              title:'Test title',
              imageURL:'https://m.media-amazon.com/images/M/MV5BYTRiNDQwYzAtMzVlZS00NTI5LWJjYjUtMzkwNTUzMWMxZTllXkEyXkFqcGdeQXVyNDIzMzcwNjc@._V1_.jpg',
              genre: 'TV series',
              actor: 'Test actor',
              rank: 13,
              year: 2020
          );
          final MovieEntity test2 = MovieEntity(
              id: ImdbID(id: 'tt0944947'),
              title:'Test long long long long long long title',
              imageURL:'https://m.media-amazon.com/images/M/MV5BMmYyOTgwYWItYmU3Ny00M2E2LTk0NWMtMDVlNmQ0MWZiMTMxXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_.jpg',
              genre: 'TV series',
              actor: 'Test actor',
              rank: 13,
              year: 2020
          );
          moviesList = [test, test2];
          print(moviesList);
          yield MovieLoadedSuccessfulState(moviesList);
        } catch (e) {
          print('Yea I did this');
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
