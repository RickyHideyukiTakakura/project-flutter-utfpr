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
      title: json['title'] ?? 0,
      description: json['overview'] ?? 0,
      releasedYear:
          json['release_date'] != null && json['release_date'].isNotEmpty
              ? int.parse(json['release_date'].split('-')[0])
              : 0,
      duration: json['runtime'] ?? 0,
      rating: json['vote_average'] != null
          ? (json['vote_average'] as num).toDouble()
          : 0,
      // genre: List<String>.from(json['genres.name']),
      image: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : '/images/no_image_available.jpeg',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
