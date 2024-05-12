import 'package:flutter/material.dart';
import 'package:myapp/models/movie.dart';
import 'package:myapp/views/details_page.dart';

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
              movieId: movie.id,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 120,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: movie.image.startsWith('http')
                    ? Image.network(
                        movie.image,
                        fit: BoxFit.fill,
                        height: 160,
                      )
                    : Image.asset(
                        movie.image,
                        fit: BoxFit.fill,
                        height: 160,
                      ),
              ),
            ),
            Expanded(
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
