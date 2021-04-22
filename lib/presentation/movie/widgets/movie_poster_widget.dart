import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter/material.dart';

class MoviePosterWidget extends StatelessWidget {
  final MovieEntity movie;

  MoviePosterWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    try {
      return Image.network(
        this.movie.imageURL,
        fit: BoxFit.fill,
        errorBuilder: (context, dynamic, error) =>
          Image.asset(
            'assets/images/error-image.png',
            fit: BoxFit.fill,
          ),
      );
    } catch (e) {
      return Image.asset(
        'assets/images/error-image.png',
        fit: BoxFit.fill,
      );
    }
  }
}
