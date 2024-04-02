import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/movie_repository.dart';

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
      height: 150,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              "Most Popular Movies",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: MovieCard(movie: movies[index]),
                );
              },
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
    return SizedBox(
      width: 100,
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
    );
  }
}
