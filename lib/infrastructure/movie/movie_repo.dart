import 'package:flutter_app_demo/domain/movie/i_movie_repo.dart';
import 'package:flutter_app_demo/domain/movie/imdb_id.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieRepoImpl implements IMovieRepo{
  final Map<String, String> requestHeaders = const {
    'x-rapidapi-key': '91e1259ecamshcf3f7c623b5e1e0p18e596jsn60f68229d621',
    'x-rapidapi-host': 'imdb8.p.rapidapi.com',
  };

  @override
  Future<List<MovieEntity>> getMovieListOnline(String searchString) async {
    List<MovieEntity> _movies = [];
    try {
      var url = Uri.parse('https://imdb8.p.rapidapi.com/auto-complete?q=$searchString');
      var response = await http.get(url, headers: requestHeaders);

      addToMovieListFromResponse(_movies, response);
    } catch (e) {
      print("Unexpected Error occurred in Get request to https://imdb8.p.rapidapi.com/auto-complete?q=$searchString");
    }
    return _movies;
  }

  void addToMovieListFromResponse(List<MovieEntity> movies, http.Response response) {
    try {
      if (response.statusCode == 200) {
        var responseBodyMap = json.decode(response.body)['d'];
        for (var map in responseBodyMap) {
          final ImdbID id = ImdbID(id: map['id']);
          final String title = map['l'];
          final String imageUrl = map['i']['imageUrl'];
          final String genre = map['q'];
          final int rank = map['rank'];
          final String actor = map['s'];
          final int year = map['y'];
          final MovieEntity movie = MovieEntity(
            id: id,
            title: title,
            imageURL: imageUrl,
            genre: genre,
            rank: rank,
            actor: actor,
            year: year
          );
          movies.add(movie);
        }
      }
    } catch (e) {
      print("Unexpected Error occurred in Response object");
    }
  }
}