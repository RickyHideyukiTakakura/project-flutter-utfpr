import 'package:myapp/models/movie.dart';

class MovieRepository {
  static List<Movie> table = [
    Movie(
      title: "The Shawshank Redemption",
      description:
          "Over the course of several years, two convicts form a friendship, seeking consolation and, eventually, redemption through basic compassion.",
      director: "Frank Darabont",
      releasedYear: 1994,
      duration: 142,
      rating: 9.3,
      genre: ["Drama"],
      image: "./images/the_shawshank_redemption.jpeg",
    ),
    Movie(
      title: "The Godfather",
      description:
          "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
      director: "Francis Ford Coppola",
      releasedYear: 1972,
      duration: 175,
      rating: 9.2,
      genre: ["Crime", "Drama"],
      image: "./images/the_godfather.jpg",
    ),
    Movie(
      title: "The Dark Knight",
      description:
          "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
      director: "Christopher Nolan",
      releasedYear: 2008,
      duration: 152,
      rating: 9.0,
      genre: ["Action", "Crime", "Drama"],
      image: "./images/the_dark_knight.jpg",
    ),
    Movie(
      title: "The Godfather: Part II",
      description:
          "The early life and career of Vito Corleone in 1920s New York is portrayed while his son, Michael, expands and tightens his grip on the family crime syndicate.",
      director: "Francis Ford Coppola",
      releasedYear: 1974,
      duration: 202,
      rating: 9.0,
      genre: ["Crime", "Drama"],
      image: "./images/the_godfather_part2.jpg",
    ),
    Movie(
        title: "12 Angry Men",
        description:
            "A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.",
        director: "Sidney Lumet",
        releasedYear: 1957,
        duration: 96,
        rating: 9.0,
        genre: ["Crime", "Drama"],
        image: "./images/12_angry_men.jpg"),
    Movie(
      title: "Interstellar",
      description:
          "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
      director: "Christopher Nolan",
      releasedYear: 2014,
      duration: 169,
      rating: 8.6,
      genre: ["Fiction"],
      image: "./images/interstellar.jpeg",
    ),
  ];
}
