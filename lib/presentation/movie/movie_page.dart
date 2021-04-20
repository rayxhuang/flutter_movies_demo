import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/core/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
          movieRepo: MovieRepoImpl(),
          networkBloc: BlocProvider.of<NetworkBloc>(context),
      )..add(GetMovies()),
      child: BlocBuilder<MovieBloc, MovieState>(
        builder: (BuildContext context, state) {
          if (state is MovieLoaded) {
            return Container();
          } else {
            return MovieLoadingWidget();
          }
        },
      )
    );
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
            CircularProgressIndicator(),
            const SizedBox(height: 10,),
            const Text('Connected to internet, loading...'),
          ],
        ),
      )
    );
  }
}
