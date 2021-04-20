import 'package:flutter_app_demo/domain/movie/i_movie_repo.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:http/http.dart' as http;

class MovieRepoImpl implements IMovieRepo{
  @override
  Future<List<Movie>> getMovies(String search) async {
    var url = Uri.parse('https://fake-movie-database-api.herokuapp.com/api?s=$search');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}