import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_demo/application/core/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/movie/imbd_id.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkBloc extends Mock implements NetworkBloc {}
class MockMovieRepoImpl extends Mock implements MovieRepoImpl {}

void main(){
  MockNetworkBloc _networkBloc;
  MockMovieRepoImpl _movieRepo;
  Movie _movie;

  setUp(() {
    _networkBloc = MockNetworkBloc();
    _movieRepo = MockMovieRepoImpl();
    _movie = Movie(id: ImbdID(), title: "Test", imageURL: "Test");
  });

  blocTest(
    'Should emit Loading, Loaded state when phone has connection',
    build: () {
      final tHasConnection = Future.value(true);
      when(_networkBloc.isConnected()).thenAnswer((_) async => tHasConnection);
      when(_movieRepo.getMovies(any)).thenAnswer((_) async => [_movie]);
      return MovieBloc(networkBloc: _networkBloc, movieRepo: _movieRepo);
    },
    act: (bloc) => {
      bloc.add(GetMovies())
    },
    expect: () => [isA<MovieLoading>(), isA<MovieLoaded>()],
  );

  blocTest(
    'Should emit error state when phone has no connection',
    build: () {
      final tHasConnection = Future.value(false);
      when(_networkBloc.isConnected()).thenAnswer((_) async => tHasConnection);
      return MovieBloc(networkBloc: _networkBloc);
    },
    act: (bloc) => {
      bloc.add(GetMovies())
    },
    expect: () => [isA<MovieError>()],
  );
}