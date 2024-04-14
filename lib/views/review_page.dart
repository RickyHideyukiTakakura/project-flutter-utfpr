import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/widgets/review/review_form.dart';

class ReviewPage extends StatelessWidget {
  final Movie movie;

  const ReviewPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Write your review"),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ReviewForm(movie: movie),
      ),
    );
  }
}
