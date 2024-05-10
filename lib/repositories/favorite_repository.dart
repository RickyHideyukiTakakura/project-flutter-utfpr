import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/database/db_firestore.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/movie_repository.dart';
import 'package:myapp/services/auth_service.dart';

class FavoriteRepository extends ChangeNotifier {
  final List<Movie> _favoriteMoviesList = [];
  late FirebaseFirestore db;
  late AuthService auth;

  FavoriteRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readRepository();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readRepository() async {
    if (auth.activeUser != null && _favoriteMoviesList.isEmpty) {
      final snapshot = await db
          .collection('users/${auth.activeUser!.uid}/favoriteMovies')
          .get();

      snapshot.docs.forEach((doc) async {
        Movie movie = await MovieRepository.fetchMovieDetails(doc.get('id'));
        _favoriteMoviesList.add(movie);

        notifyListeners();
      });
    }
  }

  UnmodifiableListView<Movie> get favoriteMoviesList =>
      UnmodifiableListView(_favoriteMoviesList);

  addFavorite(List<Movie> movies) {
    movies.forEach(
      (movie) async {
        if (!_favoriteMoviesList.any((current) => current.id == movie.id)) {
          _favoriteMoviesList.add(movie);
          await db
              .collection('users/${auth.activeUser!.uid}/favoriteMovies')
              .doc(movie.id)
              .set(
            {
              'id': movie.id,
              'title': movie.title,
              'image': movie.image,
            },
          );
        }
      },
    );

    notifyListeners();
  }

  removeFavorite(Movie movie) async {
    await db
        .collection('users/${auth.activeUser!.uid}/favoriteMovies')
        .doc(movie.id)
        .delete();

    _favoriteMoviesList.remove(movie);

    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favoriteMoviesList.contains(movie);
  }
}
