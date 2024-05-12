import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/repositories/movie_repository.dart';
import 'package:myapp/views/details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<List<Movie>>? _searchResults;

  _searchMovies() {
    setState(() {
      _searchResults = MovieRepository.searchMovies(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Search Movies',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple[100]!,
                ),
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter movie name',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchMovies,
                  ),
                ),
                onSubmitted: (value) => _searchMovies(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Movie>>(
              future: _searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Movie movie = snapshot.data![index];
                      return ListTile(
                        title: Text(movie.title),
                        subtitle: Text('${movie.releasedYear}'),
                        leading: movie.image.startsWith('http')
                            ? Image.network(
                                movie.image,
                                width: 40,
                              )
                            : Image.asset(
                                'images/no_image_available.jpeg',
                                fit: BoxFit.cover,
                                width: 40,
                              ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsPage(
                                movieId: movie.id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('No results found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
