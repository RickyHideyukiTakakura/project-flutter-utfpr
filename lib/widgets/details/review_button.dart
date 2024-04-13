import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/views/review_page.dart';

class ReviewButton extends StatelessWidget {
  final Movie movie;

  const ReviewButton({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    navigateToReviewPage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ReviewPage(movie: movie),
        ),
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.only(right: 16, left: 16),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: navigateToReviewPage,
      child: const Text("Rate or Review"),
    );
  }
}
