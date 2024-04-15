import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';

class FavoriteRepository extends ChangeNotifier {
  final List<Movie> _favoriteMoviesList = [];

  UnmodifiableListView<Movie> get favoriteMoviesList =>
      UnmodifiableListView(_favoriteMoviesList);

  addFavorite(Movie movie) {
    if (!_favoriteMoviesList.contains(movie)) {
      _favoriteMoviesList.add(movie);
    }

    notifyListeners();
  }

  removeFavorite(Movie movie) {
    _favoriteMoviesList.remove(movie);

    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favoriteMoviesList.contains(movie);
  }
}
