import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/models/movie.dart';

class MovieRepository {
  static const _apiKey = '939e096e7e9b8a049aab66733f4d9f7f';
  static final Map<String, Movie> moviesCache = {};

  static Future<List<Movie>> fetchMovies() async {
    const url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> moviesJson = jsonDecode(response.body)['results'];
      List<Movie> movies =
          moviesJson.map((json) => Movie.fromJson(json)).toList();
      for (var movie in movies) {
        moviesCache[movie.id] = movie;
      }
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<Movie> fetchMovieDetails(String movieId) async {
    if (moviesCache.containsKey(movieId)) {
      return moviesCache[movieId]!;
    }

    final url = 'https://api.themoviedb.org/3/movie/$movieId?api_key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Movie movie = Movie.fromJson(jsonDecode(response.body));
      moviesCache[movieId] = movie;
      return movie;
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
