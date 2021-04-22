part of 'movie_bloc.dart';

@immutable
abstract class MovieState extends Equatable{
  @override
  List<Object> get props => [];
}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedSuccessfulState extends MovieState {
  final List<MovieEntity> movies;

  MovieLoadedSuccessfulState(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieShowDetailState extends MovieState {
  final MovieEntity movie;

  MovieShowDetailState(this.movie);

  @override
  List<Object> get props => [movie];
}

class MovieErrorState extends MovieState {}