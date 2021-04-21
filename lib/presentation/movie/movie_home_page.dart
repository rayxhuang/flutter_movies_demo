import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation_const.dart';
import 'movie_view.dart';

class MovieHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[600],
          leading: const Icon(
            Icons.movie,
            color: Colors.orange,
          ),
          title: Padding(
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
          ),
          actions: [
            IconButton(
              //TODO
              onPressed: (){ BlocProvider.of<NetworkBloc>(context).add(NetworkGetConnectivityEvent()); },
              icon: const Icon(
                Icons.refresh,
                color: kAppBarSubTitleColor,
              ),
            ),
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.search,
                color: kAppBarSubTitleColor,
              ),
            )
          ],
        ),
        body: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (BuildContext context, state) {
            if (state is NetworkConnectedState) {
              return MoviePage();
            } else {
              return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10,),
                      const Text('No Internet Connection'),
                      const Text('Retrying in 30 seconds'),
                    ],
                  ),
                ),
              );
            }
          },
        )
    );
  }
}
