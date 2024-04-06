import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;

  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {},
          ),
          title: Text(movie.title),
        ),
        body: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          child: Row(
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
                  )
                ],
              )
            ],
          ),
        ));
  }
}
