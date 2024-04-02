import 'package:myapp/models/movie.dart';

class MovieRepository {
  static List<Movie> table = [
    Movie(
      title: "The Shawshank Redemption",
      description:
          "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency",
      category: ["Drama"],
      image: "./images/the_shawshank_redemption.jpeg",
    ),
    Movie(
      title: "The Godfather",
      description:
          "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
      category: ["Crime", "Drama"],
      image: "./images/the_godfather.jpg",
    ),
    Movie(
      title: "The Dark Knight",
      description:
          "When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.",
      category: ["Action", "Crime", "Drama"],
      image: "./images/the_dark_knight.jpg",
    ),
    Movie(
      title: "The Godfather: Part II",
      description:
          "The early life and career of Vito Corleone in 1920s New York is portrayed while his son, Michael, expands and tightens his grip on the family crime syndicate.",
      category: ["Crime", "Drama"],
      image: "./images/the_godfather_part2.jpg",
    ),
    Movie(
      title: "12 Angry Men",
      description: "A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.",
      category: ["Crime", "Drama"],
      image: "./images/12_angry_men.jpg"
    ),
    Movie(
      title: "Interstellar",
      description:
          "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
      category: ["Fiction"],
      image: "./images/interstellar.jpeg",
    ),
  ];
}
