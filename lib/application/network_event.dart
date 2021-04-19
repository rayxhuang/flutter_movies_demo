part of 'network_bloc.dart';

@immutable
abstract class NetworkEvent {}

class GetConnectivity extends NetworkEvent {}