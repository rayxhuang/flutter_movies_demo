import 'package:equatable/equatable.dart';

class ImbdID extends Equatable {
  final String id;

  ImbdID({this.id = "zz0000000"});

  String get imbdID => this.id;

  @override
  List<Object> get props => [this.id];
}