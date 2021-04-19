import 'package:flutter/material.dart';

import 'presentation_const.dart';

class MyAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
            body: Container()
        )
    );
  }
}