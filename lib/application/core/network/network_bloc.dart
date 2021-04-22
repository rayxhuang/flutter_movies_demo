import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:meta/meta.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final NetworkInfoImpl networkInfo;

  NetworkBloc({@required this.networkInfo}) : super(NetworkInitialState());

  @override
  Stream<NetworkState> mapEventToState(
    NetworkEvent event,
  ) async* {
    bool connected = await isConnectedToInternet();
    if (event is NetworkGetConnectivityRecursiveEvent) {
      if (connected) {
        yield NetworkConnectedState();
      } else{
        yield NetworkLostConnectionState();
      }
      checkConnectionRecursively();
    } else if (event is NetworkGetConnectivityEvent) {
      if (connected) {
        yield NetworkConnectedInitialState();
        checkConnectionRecursively();
      } else{
        yield NetworkDisconnectedState();
        Future.delayed(
          const Duration(seconds: 30),
          () => this.add(NetworkGetConnectivityEvent()),
        );
      }
    } else {
      throw Exception("Unexpected error occurred! This is not possible");
    }
  }

  Future<bool> isConnectedToInternet() async {
    return networkInfo.isConnected;
  }

  void checkConnectionRecursively() {
    Future.delayed(
      const Duration(seconds: 30),
      () => this.add(NetworkGetConnectivityRecursiveEvent()),
    );
  }
}
