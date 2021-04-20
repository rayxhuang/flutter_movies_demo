import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation_const.dart';

class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
          create: (BuildContext context) => NetworkBloc(
            networkInfo: NetworkInfoImpl(
              connectionChecker: DataConnectionChecker()
            )
          )..add(GetConnectivity()),
          child: Scaffold(
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
                  onPressed: (){},
                  icon: const Icon(
                    Icons.location_on,
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
                if (state is Connected) {
                  return Container();
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    )
                  );
                }
              },
            )
          ),
        )
    );
  }
}