import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';

class DetailsPage extends StatelessWidget {
  Movie movie;

  DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(movie.image),
        Text(
          movie.title,
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
        Text(
          movie.description,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
