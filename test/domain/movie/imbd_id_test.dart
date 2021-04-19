import 'package:flutter_app_demo/domain/core/failure.dart';
import 'package:flutter_app_demo/domain/movie/imbd_id.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Should return default imbdID instance with no paras passed into constructor',
    () {
      final result = ImbdID();

      expect(result, ImbdID(id: "zz0000000"));
    }
  );

  test(
    'Should return default String id when getter is called',
    () {
      final result = ImbdID().imbdID.fold((l) => l, (r) => r);

      expect(result, "zz0000000");
    }
  );

  test(
    'Should return String id when getter is called',
    () {
      final result = ImbdID(id: "tt1234567").imbdID.fold((l) => l, (r) => r);

      expect(result, "tt1234567");
    }
  );

  test(
    'Should return IDFailure when getter is called on invalid ID',
    () {
      final result = ImbdID(id: "asdasd").imbdID.fold((l) => l, (r) => r);

      expect(result, IDFailure("asdasd"));
    }
  );
}