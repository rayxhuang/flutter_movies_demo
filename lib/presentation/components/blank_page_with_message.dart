import 'package:flutter/material.dart';

class BlankPageMessageWidget extends StatelessWidget {
  final String message;
  final String subMessage;

  BlankPageMessageWidget({this.message = " ", this.subMessage = " "});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10,),
              Text('$message'),
              const SizedBox(height: 3,),
              Text('$subMessage'),
            ],
          ),
        )
    );
  }
}