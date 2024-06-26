import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/database/db_firestore.dart';
import 'package:myapp/models/review.dart';
import 'package:myapp/services/auth_service.dart';

class ReviewRepository extends ChangeNotifier {
  final List<Review> _reviews = [];
  late FirebaseFirestore db;
  late AuthService auth;

  late final StreamSubscription<User?> authListener;

  ReviewRepository({required this.auth}) {
    authListener =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        _startRepository();
      } else {
        _clearReviews();
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
    if (auth.activeUser != null) {
      final snapshot =
          await db.collection('users/${auth.activeUser!.uid}/reviews').get();

      for (var doc in snapshot.docs) {
        Review review = Review(
          id: doc.get('id'),
          movieTitle: doc.get('movieTitle'),
          movieId: doc.get('movieId'),
          reviewText: doc.get('reviewText'),
          rating: doc.get('rating'),
        );
        _reviews.add(review);
      }
      notifyListeners();
    }
  }

  _clearReviews() {
    _reviews.clear();

    notifyListeners();
  }

  List<Review> get allReviews => List.unmodifiable(_reviews);

  List<Review> getReviewsByMovieId(String movieId) {
    return _reviews.where((review) => review.movieId == movieId).toList();
  }

  List<Review> get lastTwoReviews {
    return _reviews.length <= 2
        ? List.unmodifiable(_reviews)
        : List.unmodifiable(_reviews.reversed.take(2).toList().reversed);
  }

  addReview(Review review) async {
    await db
        .collection('users/${auth.activeUser!.uid}/reviews')
        .doc(review.id)
        .set({
      'id': review.id,
      'movieTitle': review.movieTitle,
      'movieId': review.movieId,
      'reviewText': review.reviewText,
      'rating': review.rating,
    });
    _reviews.add(review);

    notifyListeners();
  }

  removeReview(Review review) async {
    await db
        .collection('users/${auth.activeUser!.uid}/reviews')
        .doc(review.id)
        .delete();

    _reviews.remove(review);

    notifyListeners();
  }
}
