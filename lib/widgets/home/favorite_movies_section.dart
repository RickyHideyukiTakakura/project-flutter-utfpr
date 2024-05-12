import 'package:flutter/material.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:myapp/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class FavoriteMoviesSection extends StatefulWidget {
  const FavoriteMoviesSection({Key? key}) : super(key: key);

  @override
  State<FavoriteMoviesSection> createState() => _FavoriteMoviesSectionState();
}

class _FavoriteMoviesSectionState extends State<FavoriteMoviesSection> {
  // late FavoriteRepository favoriteMovie;

  @override
  Widget build(BuildContext context) {
    // favoriteMovie = Provider.of<FavoriteRepository>(context);

    return SizedBox(
      height: 240,
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
            child: Consumer<FavoriteRepository>(
              builder: (context, favoriteMovie, child) {
                return (favoriteMovie.favoriteMoviesList.isEmpty)
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
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
