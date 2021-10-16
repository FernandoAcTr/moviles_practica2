import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/src/data/models/movie.dart';
import 'package:practica2/src/data/models/actor.dart';

class MovieService {
  // final apiKey = 'e2dc6a6246da72420a469e4a398c0874';
  final apiKey = '2ea8ea675bd5a34a75e9428ca22adc65';

  // Cast enpoint
  // https://api.themoviedb.org/3/movie/580489/credits?api_key=2ea8ea675bd5a34a75e9428ca22adc65&language=es-MX&page=1

  Future<List<Movie>> getPopularMovies() async {
    final url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=es-MX&page=1';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    return List<Movie>.from(json["results"].map((x) => Movie.fromMap(x)));
  }

  Future<List<Movie>> getInCinemas() async {
    final url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=es-MX&page=1';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    return List<Movie>.from(json["results"].map((x) => Movie.fromMap(x)));
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=es-MX&page=1';
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    return List<Actor>.from(json['cast'].map((x) => Actor.fromMap(x)));
  }
}
