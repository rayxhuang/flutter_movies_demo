import 'package:flutter/material.dart';
import 'package:flutter_app_demo/presentation/movie_app.dart';
import 'package:http/http.dart' as http;

void main() async {
  //var url = Uri.parse('https://www.imdb.com/title/tt0096895/');
  final Map<String, String> requestHeaders = {
    'x-rapidapi-key': '1edc6b1495msh9b607fa3e9cde29p1b2779jsn16386b8819c0',
    'x-rapidapi-host': 'imdb8.p.rapidapi.com',
  };

  var url = Uri.parse('https://imdb8.p.rapidapi.com/auto-complete?q=game of thr');
  //var response = await http.get(url, headers: requestHeaders);
  //print(response.body);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyMovieApp());
}