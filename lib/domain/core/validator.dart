import 'package:dartz/dartz.dart';
import 'package:flutter_app_demo/domain/core/failure.dart';

Either<IDFailure, String> validateImbdID(String input) {
  final imbdIDRegex = RegExp(r"[a-z][a-z]\d{7}", caseSensitive: false);
  if (imbdIDRegex.hasMatch(input)) {
    return Right(input);
  } else {
    return Left(IDFailure(input));
  }
}