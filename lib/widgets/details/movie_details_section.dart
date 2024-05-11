import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:provider/provider.dart';

class MovieDetailsSection extends StatelessWidget {
  final Movie movie;

  const MovieDetailsSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteRepository>(
      builder: (context, favoriteMovie, child) {
        return Column(
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
                    child: Image.network(
                      movie.image,
                      fit: BoxFit.cover,
                      height: 220,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            if (favoriteMovie.isFavorite(movie)) {
                              favoriteMovie.removeFavorite(movie);
                            } else {
                              favoriteMovie.addFavorite([movie]);
                            }
                          },
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: Icon(
                            favoriteMovie.isFavorite(movie)
                                ? Icons.favorite
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
                  Text("Rating: ${movie.rating}"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
