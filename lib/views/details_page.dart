import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/widgets/details/movie_details_section.dart';
import 'package:myapp/widgets/details/review_button.dart';
import 'package:myapp/widgets/details/review_section.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;

  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(movie.title),
        ),
        body: DetailsContent(movie: movie));
  }
}

class DetailsContent extends StatelessWidget {
  final Movie movie;

  const DetailsContent({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MovieDetailsSection(movie: movie),
          ReviewButton(movie: movie),
          const SizedBox(height: 48),
          ReviewSection(movieTitle: movie.title),
        ],
      ),
    );
  }
}
