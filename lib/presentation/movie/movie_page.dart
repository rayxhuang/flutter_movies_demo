import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/movie/movie.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
        movieRepo: MovieRepoImpl(),
        networkBloc: BlocProvider.of<NetworkBloc>(context),
      )..add(MovieGetMoviesEvent()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (BuildContext context, state) {
          if (state is MovieLoadedSuccessfulState) {
            return Container(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.618,
                children: buildMovieGridViewChildren(state.movies),
              ),
            );
          } else {
            return MovieLoadingWidget();
          }
        },
      )
    );
  }

  List<Widget> buildMovieGridViewChildren(List<MovieEntity> movies) {
    List<Widget> widgetList = [];
    for (MovieEntity movie in movies) {
      widgetList.add(MovieDisplayWidget(movie: movie));
    }
    return widgetList;
  }
}

class MovieLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10,),
            const Text('Connected to internet, loading...'),
          ],
        ),
      )
    );
  }
}

class MovieDisplayWidget extends StatelessWidget {
  final MovieEntity movie;
  
  MovieDisplayWidget({@required this.movie});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image.network(this.movie.imageURL),
      )
    );
  }
}

