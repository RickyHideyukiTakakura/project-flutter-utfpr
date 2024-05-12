import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/database/db_firestore.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/services/auth_service.dart';

class FavoriteRepository extends ChangeNotifier {
  final List<Movie> _favoriteMoviesList = [];
  late FirebaseFirestore db;
  late AuthService auth;
  late final StreamSubscription<User?> authListener;

  FavoriteRepository({required this.auth}) {
    authListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _startRepository();
      } else {
        _clearFavorites();
      }
    });
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

      for (var doc in snapshot.docs) {
        var data = doc.data();

        Movie movie = Movie(
          id: data['id'],
          title: data['title'],
          image: data['image'],
          description: data['description'],
          releasedYear: data['releasedYear'],
          duration: data['duration'],
          rating: data['rating'],
        );

        _favoriteMoviesList.add(movie);
        notifyListeners();
      }
    }
  }

  _clearFavorites() {
    _favoriteMoviesList.clear();
    notifyListeners();
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
              'description': movie.description,
              'releasedYear': movie.releasedYear,
              'duration': movie.duration,
              'rating': movie.rating,
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
