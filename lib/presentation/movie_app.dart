import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/application/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/movie/search/movie_search_bloc.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_app_demo/infrastructure/movie/movie_repo.dart';
import 'package:flutter_app_demo/presentation/movie/movie_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataConnectionChecker _dataConnectionChecker = DataConnectionChecker();
    final NetworkInfoImpl _networkInfo = NetworkInfoImpl(connectionChecker: _dataConnectionChecker);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NetworkBloc(
              networkInfo: _networkInfo
            )..add(NetworkGetConnectivityEvent()),
          ),
          BlocProvider(
            create: (context) => MovieBloc(
              movieRepo: MovieRepoImpl(),
              networkInfo: _networkInfo
            )..add(MovieGetMoviesEvent()),
          ),
          BlocProvider(
            create: (context) => MovieSearchBloc(),
          ),
        ],
        child: MovieHomePage(),
      ),
    );
  }
}