import 'package:flutter/material.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:myapp/widgets/review_card.dart';
import 'package:provider/provider.dart';

class MyReviewsPage extends StatelessWidget {
  const MyReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12.0),
        child: Consumer<ReviewRepository>(
          builder: (context, reviews, child) {
            return reviews.allReviews.isEmpty
                ? const ListTile(
                    leading: Icon(Icons.reviews),
                    title: Text('No review added'),
                  )
                : ListView.builder(
                    itemCount: reviews.allReviews.length,
                    itemBuilder: (_, index) {
                      return ReviewCard(review: reviews.allReviews[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
