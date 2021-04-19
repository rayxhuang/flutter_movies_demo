import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main(){
  MockDataConnectionChecker _connectionChecker;
  NetworkInfoImpl _networkInfo;

  setUp(() {
    _connectionChecker = MockDataConnectionChecker();
    _networkInfo = NetworkInfoImpl(_connectionChecker);
  });

  test(
    'Should forward the call to DataConnectionChecker',
      () async {
        final tHasConnection = Future.value(true);
        when(_connectionChecker.hasConnection).thenAnswer((_) => tHasConnection);

        final result = _networkInfo.isConnected;

        verify(_connectionChecker.hasConnection);
        expect(result, tHasConnection);
      }
  );
}