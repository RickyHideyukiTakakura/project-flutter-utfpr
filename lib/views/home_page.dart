import 'package:flutter/material.dart';
import 'package:myapp/widgets/home/favorite_movies_section.dart';
import 'package:myapp/widgets/home/greetings.dart';
import 'package:myapp/widgets/home/my_reviews_section.dart';
import 'package:myapp/widgets/home/popular_movies_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome(),
      body: const HomeContent(),
    );
  }

  AppBar appBarHome() => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => {},
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
      );
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Greetings(name: 'Ricky'),
          PopularMoviesSection(),
          SizedBox(height: 20),
          FavoriteMoviesSection(),
          MyReviewsSection(),
        ],
      ),
    );
  }
}
