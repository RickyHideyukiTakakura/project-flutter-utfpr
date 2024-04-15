import 'package:flutter/material.dart';
import 'package:myapp/models/review.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatefulWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late ReviewRepository reviewList;

  @override
  Widget build(BuildContext context) {
    reviewList = Provider.of<ReviewRepository>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: InkWell(
          onLongPress: () => showPopupMenu(context),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.movie),
                title: Text(widget.review.movieTitle),
                subtitle: const Text('Review by User'),
                trailing: Text("Rate: ${widget.review.rating}/10"),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.review.reviewText,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showPopupMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + renderBox.size.width - 50,
        offset.dy,
        offset.dx + renderBox.size.width,
        offset.dy + renderBox.size.height,
      ),
      items: [
        PopupMenuItem(
          child: ListTile(
            title: const Text("Remove from reviews"),
            dense: true,
            onTap: () {
              Navigator.pop(context);

              reviewList.removeReview(widget.review);
            },
          ),
        ),
      ],
    );
  }
}
