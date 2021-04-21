import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/application/movie/movie_bloc.dart';
import 'package:flutter_app_demo/application/movie/search/movie_search_bloc.dart';
import 'package:flutter_app_demo/presentation/components/blank_page_with_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation_const.dart';
import 'movie_view_page.dart';

class MovieHomePage extends StatelessWidget {
  final TextEditingController _inputController = TextEditingController(text: 'Batman');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[600],
          leading: const Icon(
            Icons.movie,
            color: Colors.orange,
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
        body: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (BuildContext context, state) {
            if (state is NetworkConnectedState ||
                state is NetworkLostConnectionState) {
              return MoviePage();
            } else {
              return BlankPageMessageWidget(
                message: 'No Internet Connection',
                subMessage: 'Retrying in 30 seconds',
              );
            }
          },
        )
    );
  }
}