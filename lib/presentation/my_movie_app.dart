import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_app_demo/presentation/movie/movie_home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
          create: (context) => NetworkBloc(
            networkInfo: NetworkInfoImpl(
              connectionChecker: DataConnectionChecker()
            )
          )..add(NetworkGetConnectivityEvent()),
          child: MovieHomePage(),
        )
    );
  }
}