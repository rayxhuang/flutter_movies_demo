part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieSearchGetInputEvent extends MovieSearchEvent{}

class MovieSearchTerminatingEvent extends MovieSearchEvent{
  final String searchString;

  MovieSearchTerminatingEvent({this.searchString = ""});

  @override
  List<Object> get props => [searchString];
}
