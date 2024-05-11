import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/movie_repository.dart';
import 'package:myapp/widgets/details/movie_details_section.dart';
import 'package:myapp/widgets/details/review_button.dart';
import 'package:myapp/widgets/details/review_section.dart';

class DetailsPage extends StatelessWidget {
  final String movieId;

  const DetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: FutureBuilder<Movie>(
          future: MovieRepository.fetchMovieDetails(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return const Text("Error");
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      body: FutureBuilder<Movie>(
        future: MovieRepository.fetchMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return DetailsContent(movie: snapshot.data!);
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
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
          ReviewSection(movieId: movie.id),
        ],
      ),
    );
  }
}
