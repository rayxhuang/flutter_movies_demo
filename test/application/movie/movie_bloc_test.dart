import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_demo/application/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/movie/imdb_id.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkBloc extends Mock implements NetworkBloc {}
class MockMovieRepoImpl extends Mock implements MovieRepoImpl {}

void main(){
  MockNetworkBloc _networkBloc;
  MockMovieRepoImpl _movieRepo;
  MovieEntity _movie;

  setUp(() {
    _networkBloc = MockNetworkBloc();
    _movieRepo = MockMovieRepoImpl();
    _movie = MovieEntity(id: ImdbID(), title: "Test", imageURL: "Test");
  });

  blocTest(
    'Should emit Loading, Loaded state when phone has connection',
    build: () {
      final tHasConnection = Future.value(true);
      when(_networkBloc.isConnectedToInternet()).thenAnswer((_) async => tHasConnection);
      when(_movieRepo.getMovieListOnline(any)).thenAnswer((_) async => [_movie]);
      return MovieBloc(networkBloc: _networkBloc, movieRepo: _movieRepo);
    },
    act: (bloc) => {
      bloc.add(MovieGetMoviesEvent())
    },
    expect: () => [MovieLoadingState(), MovieLoadedSuccessfulState([_movie])],
  );

  blocTest(
    'Should emit Error state when phone has no connection',
    build: () {
      final tHasConnection = Future.value(false);
      when(_networkBloc.isConnectedToInternet()).thenAnswer((_) async => tHasConnection);
      return MovieBloc(networkBloc: _networkBloc, movieRepo: _movieRepo);
    },
    act: (bloc) => {
      bloc.add(MovieGetMoviesEvent())
    },
    expect: () => [MovieErrorState()],
  );
}