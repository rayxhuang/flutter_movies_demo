import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/movie/search/movie_search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../presentation_const.dart';
import 'views/movie_overview.dart';

class MovieHomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _inputController = useTextEditingController(text: 'Batman');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[600],
        leading: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieShowDetailState) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios,),
                onPressed: () { BlocProvider.of<MovieBloc>(context).add(MovieGoBackEvent()); },
              );
            } else {
              return kMovieIconOrange;
            }
          }
        ),
        title: BlocBuilder<MovieSearchBloc, MovieSearchState>(
          builder: (context, state) {
            if (state is MovieSearchInitial || state is MovieSearchTerminatingState) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Movies',
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                        const Text(
                          'All theaters',
                          style: TextStyle(
                            color: kAppBarSubTitleColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return TextFormField(
                controller: _inputController,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                onFieldSubmitted: (input) {
                  BlocProvider.of<MovieSearchBloc>(context).add(MovieSearchTerminatingEvent(searchString: input));
                  BlocProvider.of<MovieBloc>(context)
                      .add(MovieGetMoviesEvent(searchString: input));
                },
              );
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<MovieBloc>(context).add(MovieGetMoviesEvent(searchString: _inputController.text));
            },
            icon: const Icon(
              Icons.refresh,
              color: kAppBarSubTitleColor,
            ),
          ),
          BlocBuilder<MovieSearchBloc, MovieSearchState>(
            builder: (context, state) {
              if (state is MovieSearchGetInputState) {
                return IconButton(
                  onPressed: () {
                    BlocProvider.of<MovieSearchBloc>(context)
                        .add(MovieSearchTerminatingEvent(searchString: _inputController.text));
                    BlocProvider.of<MovieBloc>(context)
                        .add(MovieGetMoviesEvent(searchString: _inputController.text));
                  },
                  icon: const Icon(
                    Icons.search,
                    color: kAppBarSubTitleColor,
                  ),
                );
              } else {
                return IconButton(
                  onPressed: () { BlocProvider.of<MovieSearchBloc>(context).add(MovieSearchGetInputEvent()); },
                  icon: const Icon(
                    Icons.search,
                    color: kAppBarSubTitleColor,
                  ),
                );
              }
            }
          )
        ],
      ),
      body: MoviePage(),
    );
  }
}
