part of 'network_bloc.dart';

@immutable
abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class Connected extends NetworkState {}

class Disconnected extends NetworkState {}
