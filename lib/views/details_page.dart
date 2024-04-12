import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:myapp/views/review_page.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final Movie movie;

  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late FavoriteRepository favoriteMovie;

  @override
  Widget build(BuildContext context) {
    favoriteMovie = Provider.of<FavoriteRepository>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    child: Image.asset(
                      widget.movie.image,
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
                                widget.movie.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Directed by ${widget.movie.director}",
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
                            widget.movie.description,
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
                            favoriteMovie.isFavorite(widget.movie)
                                ? favoriteMovie.remove(widget.movie)
                                : favoriteMovie.add(widget.movie)
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
                            favoriteMovie.isFavorite(widget.movie)
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
                  Text("Release year: ${widget.movie.releasedYear}"),
                  Text("Duration: ${widget.movie.duration} minutes"),
                  Text(
                    "Genre: ${widget.movie.genre.asMap().entries.map((e) => e.value).join(", ")}",
                  ),
                  Text("IMDB Rating: ${widget.movie.rating}"),
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
                      movie: widget.movie,
                    ),
                  ),
                )
              },
              child: const Text("Rate or Review"),
            ),
            const SizedBox(height: 48),
            MyReview(movieTitle: widget.movie.title),
          ],
        ),
      ),
    );
  }
}

class MyReview extends StatefulWidget {
  final String movieTitle;

  const MyReview({Key? key, required this.movieTitle}) : super(key: key);

  @override
  State<MyReview> createState() => _MyReviewState();
}

class _MyReviewState extends State<MyReview> {
  late ReviewRepository reviewList;

  @override
  Widget build(BuildContext context) {
    reviewList = Provider.of<ReviewRepository>(context);
    final reviews = reviewList.getReviewsForMovie(widget.movieTitle);

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
                                title: Text(widget.movieTitle),
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
