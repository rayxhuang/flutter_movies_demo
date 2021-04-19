import 'package:flutter_app_demo/domain/movie/imbd_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';



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
      final result = ImbdID().imbdID;

      expect(result, "zz0000000");
    }
  );
}