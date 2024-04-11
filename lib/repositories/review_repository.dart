import 'package:flutter/material.dart';
import 'package:myapp/models/review.dart';

class ReviewRepository extends ChangeNotifier {
  final List<Review> _reviews = [];

  List<Review> get allReviews => List.unmodifiable(_reviews);

  List<Review> getReviewsForMovie(String movieTitle) {
    return _reviews.where((review) => review.movieTitle == movieTitle).toList();
  }

  List<Review> get lastTwoReviews {
    return _reviews.length <= 2
        ? List.unmodifiable(_reviews)
        : List.unmodifiable(_reviews.take(2));
  }

  void addReview(Review review) {
    _reviews.add(review);
    notifyListeners();
  }
}
