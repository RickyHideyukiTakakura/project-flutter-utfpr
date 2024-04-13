import 'package:flutter/material.dart';
import 'package:myapp/models/review.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:myapp/widgets/review_card.dart';
import 'package:provider/provider.dart';

class MyReviewsSection extends StatelessWidget {
  const MyReviewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewList = Provider.of<ReviewRepository>(context);
    final lastTwoReviews = reviewList.lastTwoReviews;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 16),
          child: Text(
            "My Recent Reviews",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ReviewList(reviews: lastTwoReviews),
      ],
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: reviews.isEmpty
          ? const Center(
              child: Text(
                "No movies recently reviewed",
              ),
            )
          : Column(
              children:
                  reviews.map((review) => ReviewCard(review: review)).toList(),
            ),
    );
  }
}
