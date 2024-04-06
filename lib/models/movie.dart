class Movie {
  String title;
  String description;
  String director;
  String image;
  int releasedYear;
  int duration;
  double rating;
  List<String> genre;

  Movie({
    required this.title,
    required this.description,
    required this.director,
    required this.image,
    required this.releasedYear,
    required this.duration,
    required this.rating,
    required this.genre,
  });
}
