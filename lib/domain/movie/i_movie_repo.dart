import 'movie.dart';

abstract class IMovieRepo {
  Future<List<MovieEntity>> getMovieListOnline(String searchString);
}