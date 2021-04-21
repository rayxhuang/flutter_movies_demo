import 'dart:convert';

import 'package:flutter_app_demo/domain/movie/imdb_id.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  final MovieRepoImpl movieRepo = MovieRepoImpl();

  test(
    'Should return correct List<Movie> when called',
    () async {
      final searchString = "batman";

      final result = await movieRepo.getMovieListOnline(searchString);

      expect(result.length, 9);
    }
  );

  test(
    'Should return correct List<Movie> when called',
    () async {
      final MovieEntity movie = MovieEntity(id: ImdbID(), title:'test', imageURL:'test');
      List<MovieEntity> movieList = [];
      final List<MovieEntity> matcher = [movie];
      final Response response = Response(
        jsonEncode({
          'Search':[
            {
              'imbdID':'zz0000000',
              'Title':'test',
              'Poster':'test',
            }
          ]
        }),
        200,
      );

      movieRepo.addToMovieListFromResponse(movieList, response);

      expect(movieList, matcher);
    }
  );
}