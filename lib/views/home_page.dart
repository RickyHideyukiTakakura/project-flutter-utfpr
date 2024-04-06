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
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Greetings(
              name: 'Ricky',
            ),
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
                      "No movies added to favorites",
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

class MyReviewsSection extends StatelessWidget {
  const MyReviewsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movies = MovieRepository.table;

    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
            ),
            child: Text(
              "My Recent Reviews",
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
                      "No movies recently reviewed",
                    ),
                  )
                : ListView.builder(
                    itemCount: 2,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.movie),
                                title: Text('The Irishman'),
                                subtitle: Text('Review by Adrian'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
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
