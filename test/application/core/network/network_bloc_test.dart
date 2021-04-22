import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app_demo/application/core/network/network_bloc.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkInfoImpl extends Mock implements NetworkInfoImpl {}

void main(){
  MockNetworkInfoImpl _networkInfo = MockNetworkInfoImpl();
  final tHasConnection = Future.value(true);
  final tHasNoConnection = Future.value(false);

  blocTest(
    'Should emit ConnectedInitial state when first time checking for connection',
    build: () {
      when(_networkInfo.isConnected).thenAnswer((_) async => tHasConnection);
      return NetworkBloc(networkInfo: _networkInfo);
    },
    act: (bloc) => bloc.add(NetworkGetConnectivityEvent()),
    expect: () => [NetworkConnectedInitialState()],
    verify: (_) {
      verify(_networkInfo.isConnected).called(1);
    }
  );

  blocTest(
    'Should emit Disconnected state when phone has no connection',
    build: () {
      when(_networkInfo.isConnected).thenAnswer((_) async => tHasNoConnection);
      return NetworkBloc(networkInfo: _networkInfo);
    },
    act: (bloc) => bloc.add(NetworkGetConnectivityEvent()),
    expect: () => [NetworkDisconnectedState()],
    verify: (_) {
      verify(_networkInfo.isConnected).called(1);
    }
  );

  // blocTest(
  //   'Should emit Connected state after ConnectedInitial state if phone still has connection',
  //   build: () {
  //     when(_networkInfo.isConnected).thenAnswer((_) async => tHasConnection);
  //     return NetworkBloc(networkInfo: _networkInfo);
  //   },
  //   seed: () => NetworkConnectedInitialState(),
  //   act: (bloc) => bloc.add(NetworkGetConnectivityRecursiveEvent()),
  //   expect: () => [NetworkConnectedState()],
  //   // verify: (_) {
  //   //   verify(_networkInfo.isConnected).called(3);
  //   // }
  // );
}