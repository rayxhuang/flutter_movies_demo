import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

//class MockMovieRepoImpl extends Mock implements MovieRepoImpl {}

void main() {
  final MovieRepoImpl movieRepo = MovieRepoImpl();

  test(
    'Should return correct List<Movie> when called',
    () async {
      final search = "batman";

      final result = await movieRepo.getMovies(search);

      expect(result.length, 9);
    }
  );
}