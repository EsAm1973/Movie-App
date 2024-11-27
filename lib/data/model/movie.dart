class Movie {
  final int rank;
  final String title;
  final String description;
  final String image;
  final String bigImage;
  final List<String> genre;
  final String thumbnail;
  final String rating;
  final String id;
  final int year;
  final String imdbId;
  final String imdbLink;

  Movie(
      {required this.rank,
      required this.title,
      required this.description,
      required this.image,
      required this.bigImage,
      required this.genre,
      required this.thumbnail,
      required this.rating,
      required this.id,
      required this.year,
      required this.imdbId,
      required this.imdbLink});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      rank: json['rank'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      bigImage: json['big_image'] ?? '',
      genre: List<String>.from(json['genre'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
      rating: json['rating'] ?? '',
      id: json['id'] ?? '',
      year: json['year'] ?? 0,
      imdbId: json['imdbid'] ?? '',
      imdbLink: json['imdb_link'] ?? '',
    );
  }
}
