import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_demo/application/movie/search/movie_search_bloc.dart';

void main(){
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
}