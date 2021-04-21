import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_demo/domain/core/failure.dart';
import 'package:flutter_app_demo/domain/core/validator.dart';

//This is a value object
@immutable
class ImdbID extends Equatable {
  final Either<IDFailure, String> id;

  ImdbID._(this.id);

  factory ImdbID({id}){
    return ImdbID._(
      validateImbdID(id ?? "zz0000000")
    );
  }

  Either<IDFailure, String> get imbdID => this.id;

  @override
  List<Object> get props => [this.id];

  @override
  String toString() {
    return id.fold((l) => l.message, (r) => r);
  }
}