import 'package:flutter/material.dart';
import 'package:myapp/models/review.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:myapp/widgets/review_card.dart';
import 'package:provider/provider.dart';

class ReviewSection extends StatefulWidget {
  final String movieTitle;

  const ReviewSection({Key? key, required this.movieTitle}) : super(key: key);

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  late ReviewRepository reviewList;

  @override
  Widget build(BuildContext context) {
    reviewList = Provider.of<ReviewRepository>(context);
    List<Review> reviews = reviewList.getReviewsByTitle(widget.movieTitle);

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "My Review",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ReviewList(reviews: reviews)
        ],
      ),
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
                "No review added",
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: reviews.length,
              itemBuilder: (_, index) {
                final review = reviews[index];
                return ReviewCard(review: review);
              },
            ),
    );
  }
}
