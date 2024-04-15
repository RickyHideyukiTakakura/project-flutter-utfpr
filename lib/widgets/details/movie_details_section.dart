import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/favorite_repository.dart';
import 'package:provider/provider.dart';

class MovieDetailsSection extends StatefulWidget {
  final Movie movie;

  const MovieDetailsSection({super.key, required this.movie});

  @override
  State<MovieDetailsSection> createState() => _MovieDetailsSectionState();
}

class _MovieDetailsSectionState extends State<MovieDetailsSection> {
  late FavoriteRepository favoriteMovie;

  @override
  Widget build(BuildContext context) {
    favoriteMovie = Provider.of<FavoriteRepository>(context);

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
                child: Image.asset(
                  widget.movie.image,
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
                            ? favoriteMovie.removeFavorite(widget.movie)
                            : favoriteMovie.addFavorite(widget.movie)
                      },
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
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
      ],
    );
  }
}
