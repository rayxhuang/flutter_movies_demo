import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  String get message;
}

class IDFailure extends Equatable implements Failure {
  final String errorMessage;

  IDFailure(this.errorMessage);

  @override
  String get message => this.errorMessage;

  @override
  List<Object> get props => [errorMessage];
}