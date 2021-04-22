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

const Icon kMovieIconOrange = Icon(
  Icons.movie,
  color: Colors.orange,
);

const SizedBox kSizedBoxVertical5 = SizedBox(height: 5,);

const TextStyle kMovieDetailSubtitleStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);