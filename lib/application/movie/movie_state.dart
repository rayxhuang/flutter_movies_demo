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
}

class MovieErrorState extends MovieState {}