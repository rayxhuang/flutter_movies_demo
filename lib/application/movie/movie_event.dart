part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieGetMoviesEvent extends MovieEvent {
  final String searchString;

  MovieGetMoviesEvent({this.searchString = "Batman"});

  @override
  List<Object> get props => [searchString];
}

class MovieShowDetailEvent extends MovieEvent {
  final MovieEntity movie;

  MovieShowDetailEvent({@required this.movie});

  @override
  List<Object> get props => [movie];
}

class MovieGoBackEvent extends MovieEvent {}