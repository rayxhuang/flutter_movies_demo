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
      final MovieEntity movie = MovieEntity(
        id: ImdbID(),
        title:'Test title',
        imageURL:'Test URL',
        genre: 'Test genre',
        actor: 'Test actor',
        rank: 1,
        year: 2020
      );
      List<MovieEntity> movieList = [];
      final List<MovieEntity> matcher = [movie];
      final Response response = Response(
        jsonEncode({
          'd':[
            {
              'i':{
                'imageUrl':'Test URL'
              },
              'id':'zz0000000',
              'l':'Test title',
              'q':'Test genre',
              'rank':1,
              's':'Test actor',
              'y':2020
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