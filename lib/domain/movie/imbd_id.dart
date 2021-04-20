import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_demo/domain/core/failure.dart';
import 'package:flutter_app_demo/domain/core/validator.dart';

//This is a value object
@immutable
class ImbdID extends Equatable {
  final Either<IDFailure, String> id;

  ImbdID._(this.id);

  factory ImbdID({id}){
    return ImbdID._(
      validateImbdID(id ?? "zz0000000")
    );
  }

  Either<IDFailure, String> get imbdID => this.id;

  @override
  List<Object> get props => [this.id];
}