part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {}

class MovieGetMoviesEvent extends MovieEvent {
  final String searchString;

  MovieGetMoviesEvent({this.searchString = "Batman"});

  @override
  List<Object> get props => [searchString];
}