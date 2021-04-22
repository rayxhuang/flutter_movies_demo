import 'package:flutter/material.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/presentation/movie/widgets/movie_poster_widget.dart';
import 'package:flutter_app_demo/presentation/presentation_const.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieEntity movie;

  MovieDetailPage({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePosterWidget(this.movie),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.movie.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  kSizedBoxVertical5,
                  Text(
                    'Year: ${this.movie.year.toString()}',
                    style: kMovieDetailSubtitleStyle,
                  ),
                  kSizedBoxVertical5,
                  Text(
                    this.movie.genre,
                    style: kMovieDetailSubtitleStyle,
                  ),
                  kSizedBoxVertical5,
                  Text(
                    'Staffs: ${this.movie.actor}',
                    style: kMovieDetailSubtitleStyle,
                  ),
                  kSizedBoxVertical5,
                  Text(
                    'Rank: ${this.movie.rank.toString()}',
                    style: kMovieDetailSubtitleStyle,
                  ),
                  kSizedBoxVertical5,
                  Center(
                    child: InkWell(
                      onTap: () async {
                        var url = 'https://www.imdb.com/title/${this.movie.id}/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      child: Text(
                        'External Link to IMDb',
                        style: kMovieDetailSubtitleStyle.copyWith(
                          decoration: TextDecoration.underline,
                          color: Colors.blue
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
