import 'package:flutter_app_demo/domain/movie/i_movie_repo.dart';
import 'package:flutter_app_demo/domain/movie/imbd_id.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieRepoImpl implements IMovieRepo{
  @override
  Future<List<Movie>> getMovies(String search) async {
    List<Movie> _movies = [];

    try {
      var url = Uri.parse(
          'https://fake-movie-database-api.herokuapp.com/api?s=$search');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var responseBodyMap = json.decode(response.body)['Search'];
        for (var m in responseBodyMap) {
          final ImbdID id = m['imbdID'];
          final String title = m['Title'];
          final String imageUrl = m['Poster'];
          final Movie movie = Movie(id: id, title: title, imageURL: imageUrl);
          _movies.add(movie);
        }
      }
    } catch (e) {
      print(e);
    }
    print(_movies.length);
    return _movies;
  }
}