import 'movie.dart';

abstract class IMovieRepo {
  Future<List<Movie>> getMovies(String search);
}