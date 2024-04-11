import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:myapp/views/review_page.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  final Movie movie;
  late FavoriteRepository favoriteMovie;

  DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    favoriteMovie = Provider.of<FavoriteRepository>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      movie.image,
                      fit: BoxFit.cover,
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Directed by ${movie.director}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            movie.description,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => {
                            favoriteMovie.isFavorite(movie)
                                ? favoriteMovie.remove(movie)
                                : favoriteMovie.add(movie)
                          },
                          style: const ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(0)),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            textStyle: MaterialStatePropertyAll(
                              TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          icon: Icon(
                            favoriteMovie.isFavorite(movie)
                                ? (Icons.favorite)
                                : Icons.favorite_border_outlined,
                            color: Colors.red,
                          ),
                          label: const Text("Favorite"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text("Release year: ${movie.releasedYear}"),
                  Text("Duration: ${movie.duration} minutes"),
                  Text(
                    "Genre: ${movie.genre.asMap().entries.map((e) => e.value).join(", ")}",
                  ),
                  Text("IMDB Rating: ${movie.rating}"),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.only(right: 16, left: 16),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReviewPage(
                      movie: movie,
                    ),
                  ),
                )
              },
              child: const Text("Rate or Review"),
            ),
            const SizedBox(height: 20),
            MyReview(movieTitle: movie.title),
          ],
        ),
      ),
    );
  }
}

class MyReview extends StatelessWidget {
  final String movieTitle;

  const MyReview({Key? key, required this.movieTitle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final reviewManager = Provider.of<ReviewRepository>(context);
    final reviews = reviewManager.getReviewsForMovie(movieTitle);

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
          Padding(
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.movie),
                                title: Text(movieTitle),
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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
