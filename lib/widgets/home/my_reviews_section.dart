import 'package:flutter/material.dart';
import 'package:myapp/repositories/review_repository.dart';
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
        lastTwoReviews.isEmpty
            ? const SizedBox(
                height: 240,
                child: Center(
                  child: Text("No movies recently reviewed"),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  children: List.generate(
                    lastTwoReviews.length,
                    (index) {
                      final review = lastTwoReviews[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.movie),
                                title: Text(review.movieTitle),
                                subtitle: const Text('Review by User'),
                                trailing: Text("Rate: ${review.rating}/10"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  review.reviewText,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
