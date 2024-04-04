import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/movie_repository.dart';
import 'package:myapp/views/details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Greetings(
            name: 'Ricky',
          ),
          PopularMoviesSection(),
          SizedBox(height: 20),
          FavoriteMoviesSection(),
        ],
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

class FavoriteMoviesSection extends StatelessWidget {
  const FavoriteMoviesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movies = [];

    return SizedBox(
      height: 200,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
            ),
            child: Text(
              "Favorite Movies",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: (movies.isEmpty)
                ? const Center(
                    child: Text(
                      "None movies add to favorites",
                    ),
                  )
                : ListView.separated(
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
