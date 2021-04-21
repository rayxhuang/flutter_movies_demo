import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'imdb_id.dart';

class MovieEntity extends Equatable{
  final ImdbID id;
  final String title;
  final String imageURL;

  MovieEntity({
    @required this.id,
    @required this.title,
    @required this.imageURL,
  });

  @override
  List<Object> get props => [this.id, this.title, this.imageURL];

  @override
  String toString() => [id, title].toString();
}