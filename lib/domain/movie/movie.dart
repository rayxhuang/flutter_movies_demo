import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'imbd_id.dart';


class Movie extends Equatable{
  final ImbdID id;
  final String title;
  final String imageURL;

  Movie({
    @required this.id,
    @required this.title,
    @required this.imageURL,
  });

  @override
  List<Object> get props => [this.id, this.title, this.imageURL];
}