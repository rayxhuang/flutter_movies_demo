part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchEvent extends Equatable {}

class MovieSearchGetInputEvent implements MovieSearchEvent{
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class MovieSearchTerminatingEvent implements MovieSearchEvent{
  final String searchString;

  MovieSearchTerminatingEvent({this.searchString = ""});

  List<Object> get props => [searchString];

  @override
  bool get stringify => true;
}
