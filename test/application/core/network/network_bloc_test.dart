import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkInfoImpl extends Mock implements NetworkInfoImpl {}

void main(){
  MockNetworkInfoImpl _networkInfo;

  setUp(() {
    _networkInfo = MockNetworkInfoImpl();
  });

  blocTest(
    'Should emit Connected state when phone has connection',
    build: () {
      final tHasConnection = Future.value(true);
      when(_networkInfo.isConnected).thenAnswer((_) async => tHasConnection);
      return NetworkBloc(networkInfo: _networkInfo);
    },
    act: (bloc) => bloc.add(GetConnectivity()),
    expect: () => [isA<Connected>()],
  );

  blocTest(
    'Should emit Disconnected state when phone has no connection',
    build: () {
      final tHasConnection = Future.value(false);
      when(_networkInfo.isConnected).thenAnswer((_) async => tHasConnection);
      return NetworkBloc(networkInfo: _networkInfo);
    },
    act: (bloc) => bloc.add(GetConnectivity()),
    expect: () => [isA<Disconnected>()],
  );
}