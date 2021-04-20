import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app_demo/domain/core/network_info.dart';
import 'package:meta/meta.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final NetworkInfoImpl networkInfo;

  NetworkBloc({@required this.networkInfo}) : super(NetworkInitial());

  @override
  Stream<NetworkState> mapEventToState(
    NetworkEvent event,
  ) async* {
    if (event is GetConnectivity) {
      bool connected = await isConnected();

      if (connected) {
        yield Connected();
      } else{
        yield Disconnected();
      }
    }
  }

  Future<bool> isConnected() async {
    return networkInfo.isConnected;
  }
}
