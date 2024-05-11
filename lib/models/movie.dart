class Movie {
  final String id;
  final String title;
  final String description;
  final int releasedYear;
  final int duration;
  final double rating;
  // final List<String> genre;
  final String image;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.releasedYear,
    required this.duration,
    required this.rating,
    // required this.genre,
    required this.image,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      description: json['overview'],
      releasedYear: int.parse(json['release_date'].split('-')[0]),
      duration: json['runtime'] ?? 0,
      rating: (json['vote_average'] as num).toDouble(),
      // genre: List<String>.from(json['genres.name']),
      image: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
