import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/models/review.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:provider/provider.dart';

class ReviewForm extends StatefulWidget {
  final Movie movie;

  const ReviewForm({Key? key, required this.movie}) : super(key: key);

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          MovieTitleAndRatingForm(
            movie: widget.movie,
            ratingController: ratingController,
          ),
          ReviewTextField(
            reviewController: reviewController,
          ),
          PublishButton(
            formKey: formKey,
            movie: widget.movie,
            ratingController: ratingController,
            reviewController: reviewController,
          ),
        ],
      ),
    );
  }
}

class MovieTitleAndRatingForm extends StatelessWidget {
  final Movie movie;

  final TextEditingController ratingController;

  const MovieTitleAndRatingForm({
    Key? key,
    required this.movie,
    required this.ratingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ratingController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8),
                    labelText: 'Your rating (1-10)',
                    labelStyle: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  validator: validateRating,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Image.network(
            movie.image,
            width: 160,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  String? validateRating(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a rating';
    }

    final rating = double.tryParse(value);

    if (rating == null || rating < 1 || rating > 10) {
      return 'Rating must be between 1 - 10';
    }

    return null;
  }
}

class ReviewTextField extends StatelessWidget {
  final TextEditingController reviewController;

  const ReviewTextField({
    Key? key,
    required this.reviewController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        controller: reviewController,
        maxLines: 16,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          labelText: 'Write down your review...',
          labelStyle: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class PublishButton extends StatefulWidget {
  final Movie movie;

  final TextEditingController ratingController;
  final TextEditingController reviewController;

  final GlobalKey<FormState> formKey;

  const PublishButton({
    Key? key,
    required this.formKey,
    required this.movie,
    required this.ratingController,
    required this.reviewController,
  }) : super(key: key);

  @override
  State<PublishButton> createState() => PublishButtonState();
}

class PublishButtonState extends State<PublishButton> {
  late ReviewRepository reviewList;

  @override
  Widget build(BuildContext context) {
    reviewList = Provider.of<ReviewRepository>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () => publishReview(context),
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.only(right: 16, left: 16),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text("Publish"),
        ),
      ),
    );
  }

  publishReview(BuildContext context) {
    if (widget.formKey.currentState!.validate()) {
      final newReview = Review(
        id: UniqueKey().toString(),
        movieId: widget.movie.id,
        movieTitle: widget.movie.title,
        rating: double.parse(widget.ratingController.text),
        reviewText: widget.reviewController.text,
      );

      reviewList.addReview(newReview);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Review published successfully")),
      );
    }
  }
}
