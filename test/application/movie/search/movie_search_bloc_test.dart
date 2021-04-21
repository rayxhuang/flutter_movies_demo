import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_demo/application/movie/search/movie_search_bloc.dart';

void main(){
  final MovieSearchBloc searchBloc = MovieSearchBloc();

  blocTest(
    'Should emit GetInput state',
    build: () {
      return MovieSearchBloc();
    },
    act: (bloc) => {
      bloc.add(MovieSearchGetInputEvent())
    },
    expect: () => [MovieSearchGetInputState()],
  );

  blocTest(
    'Should emit Terminating state',
    build: () {
      return MovieSearchBloc();
    },
    act: (bloc) => {
      bloc.add(MovieSearchTerminatingEvent()),
    },
    expect: () => [MovieSearchTerminatingState()],
  );

  // blocTest(
  //   'Should emit Error state when phone has no connection',
  //   build: () {
  //     final tHasConnection = Future.value(false);
  //     when(_networkInfo.isConnected).thenAnswer((_) async => tHasConnection);
  //     return MovieBloc(networkInfo: _networkInfo, movieRepo: _movieRepo);
  //   },
  //   act: (bloc) => {
  //     bloc.add(MovieGetMoviesEvent())
  //   },
  //   expect: () => [MovieErrorState()],
  // );
}