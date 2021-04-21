part of 'network_bloc.dart';

@immutable
abstract class NetworkEvent {}

class NetworkGetConnectivityEvent extends NetworkEvent {}

class NetworkGetConnectivityRecursiveEvent extends NetworkEvent {}