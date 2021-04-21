import 'package:flutter_app_demo/infrastructure/core/converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Should give correct output from searchStringConverter',
    () {
      final String rawInput = 'Bat man';
      final String output = 'Bat+man';

      final result = searchStringConverter(rawInput);

      expect(result, output);
    },
  );
}