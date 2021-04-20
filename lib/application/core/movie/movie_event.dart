part of 'movie_bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {}

class GetMovies extends MovieEvent {
  final String search;

  GetMovies({this.search});

  @override
  List<Object> get props => [search];
}