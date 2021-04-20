import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_demo/application/core/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkBloc extends Mock implements NetworkBloc {}

void main(){
  MockNetworkBloc _networkBloc;

  setUp(() {
    _networkBloc = MockNetworkBloc();
  });

  blocTest(
    'Should emit Loading, Loaded state when phone has connection',
    build: () {
      final tHasConnection = Future.value(true);
      when(_networkBloc.isConnected()).thenAnswer((_) async => tHasConnection);
      return MovieBloc(networkBloc: _networkBloc);
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