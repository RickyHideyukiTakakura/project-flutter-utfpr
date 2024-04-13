import 'package:flutter/material.dart';
import 'package:myapp/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.movie),
              title: Text(review.movieTitle),
              subtitle: const Text(
                'Review by User',
              ),
              trailing: Text("Rate: ${review.rating}/10"),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                review.reviewText,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
