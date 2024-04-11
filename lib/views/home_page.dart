import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:myapp/repositories/movie_repository.dart';
import 'package:myapp/repositories/review_repository.dart';
import 'package:myapp/views/details_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => print("Menu Button"),
        ),
        title: const Text(
          "My App",
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://github.com/rickyhideyukitakakura.png'),
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Greetings(name: 'Ricky'),
            PopularMoviesSection(),
            SizedBox(height: 20),
            FavoriteMoviesSection(),
            MyReviewsSection(),
          ],
        ),
      ),
    );
  }
}

class Greetings extends StatelessWidget {
  final String name;

  const Greetings({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 20,
          ),
          children: <TextSpan>[
            const TextSpan(text: 'Hello, '),
            TextSpan(
              text: name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularMoviesSection extends StatelessWidget {
  const PopularMoviesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movies = MovieRepository.table;

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Top Rated Movies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: MovieCard(movie: movies[index]),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsPage(
              movie: movie,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 120,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              movie.image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class FavoriteMoviesSection extends StatefulWidget {
  const FavoriteMoviesSection({Key? key}) : super(key: key);

  @override
  State<FavoriteMoviesSection> createState() => _FavoriteMoviesSectionState();
}

class _FavoriteMoviesSectionState extends State<FavoriteMoviesSection> {
  late FavoriteRepository favoriteMovie;

  @override
  Widget build(BuildContext context) {
    favoriteMovie = Provider.of<FavoriteRepository>(context);

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Favorite Movies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: (favoriteMovie.favoriteMoviesList.isEmpty)
                ? const Center(
                    child: Text("No movies added to favorites"),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: favoriteMovie.favoriteMoviesList.length,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: MovieCard(
                          movie: favoriteMovie.favoriteMoviesList[index],
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

class MyReviewsSection extends StatelessWidget {
  const MyReviewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewManager = Provider.of<ReviewRepository>(context);
    final lastTwoReviews = reviewManager.lastTwoReviews;

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
                height: 200,
                child: Center(
                  child: Text("No movies recently reviewed"),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  children: List.generate(lastTwoReviews.length, (index) {
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
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                review.reviewText,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
      ],
    );
  }
}
