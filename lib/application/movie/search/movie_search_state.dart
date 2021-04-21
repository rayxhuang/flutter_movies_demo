part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchGetInputState extends MovieSearchState{}

class MovieSearchTerminatingState extends MovieSearchState{}
