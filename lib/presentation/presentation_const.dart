import 'package:flutter/material.dart';

const Color kAppBarSubTitleColor = Colors.grey;

const SnackBar kLostConnectionSnackBar = SnackBar(
  content: const Text(
    'Lost Internet Connection!',
    textAlign: TextAlign.center,
  )
);
const SnackBar kRegainedConnectionSnackBar = SnackBar(
  content: const Text(
    'Regained Internet Connection!',
    textAlign: TextAlign.center,
  )
);