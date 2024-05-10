import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart'; // Certifique-se de importar o modelo Movie
import 'package:myapp/repositories/movie_repository.dart';
import 'package:myapp/widgets/movie_card.dart';

class PopularMoviesSection extends StatelessWidget {
  const PopularMoviesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
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
            child: FutureBuilder<List<Movie>>(
              future: MovieRepository.fetchMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length > 10
                          ? 10
                          : snapshot.data!.length,
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: MovieCard(movie: snapshot.data![index]),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
