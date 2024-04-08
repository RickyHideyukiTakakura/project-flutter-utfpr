import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/movie_repository.dart';
import 'package:myapp/views/review_page.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;

  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    movie.image,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Directed by ${movie.director}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
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
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              child: Text("Release year: ${movie.releasedYear}"),
            ),
            SizedBox(
              child: Text(
                "Duration: ${movie.duration} minutes",
              ),
            ),
            SizedBox(
              child: Text(
                "Genre: ${movie.genre.asMap().entries.map((e) => e.value).join(", ")}",
              ),
            ),
            SizedBox(
              child: Text("IMDB Rating: ${movie.rating}"),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: TextButton(
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
            ),
            const SizedBox(
              height: 20,
            ),
            const MyReview(),
          ],
        ),
      ),
    );
  }
}

class MyReview extends StatelessWidget {
  const MyReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movies = MovieRepository.table;

    return SizedBox(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 16,
            ),
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
            child: (movies.isEmpty)
                ? const Center(
                    child: Text(
                      "No review added",
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.movie),
                            title: Text('The Irishman'),
                            subtitle: Text('Review by Adrian'),
                            trailing: Text("Rate: 10/10"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
