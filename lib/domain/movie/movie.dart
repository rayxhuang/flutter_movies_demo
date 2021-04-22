import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'imdb_id.dart';

class MovieEntity extends Equatable{
  final ImdbID id;
  final String title;
  final String imageURL;
  final String genre;
  final int rank;
  final String actor;
  final int year;

  MovieEntity({
    @required this.id,
    @required this.title,
    @required this.imageURL,
    @required this.genre,
    @required this.rank,
    @required this.actor,
    @required this.year,
  });

  @override
  List<Object> get props => [this.id, this.title, this.imageURL, this.genre, this.rank, this.actor, this.year];

  @override
  String toString() => [id, title].toString();
}