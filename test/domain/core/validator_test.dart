import 'package:dartz/dartz.dart';
import 'package:flutter_app_demo/domain/core/failure.dart';
import 'package:flutter_app_demo/domain/core/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Should return Right when valid input is passed in',
    () {
      final String input = "zz0000000";
      final result = validateImbdID(input);

      expect(result, Right("zz0000000"));
    }
  );

  test(
    'Should return Right when valid input is passed in',
        () {
      final String input = "zz00000000";
      final result = validateImbdID(input);

      expect(result, Right("zz00000000"));
    }
  );

  test(
    'Should return Left when invalid input is passed in',
    () {
      final String input = "asd";
      final result = validateImbdID(input);

      expect(result, Left<IDFailure, String>(IDFailure("asd")));
    }
  );

  test(
      'Should return Left when invalid input is passed in',
      () {
        final String input = "";
        final result = validateImbdID(input);

        expect(result, Left<IDFailure, String>(IDFailure("")));
      }
  );
}