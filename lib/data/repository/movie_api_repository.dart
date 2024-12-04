import 'package:movie_app/data/api/movie_api.dart';
import 'package:movie_app/data/model/movie.dart';

class MovieApiRepository {
  final MovieService movieService;

  MovieApiRepository({required this.movieService});

  Future<List<Movie>> fetchTopMovies() async {
    final jsonData = await movieService.fetchMovies('');
    return (jsonData as List<dynamic>)
        .map<Movie>((json) => Movie.fromJson(json))
        .toList();
  }

  Future<Movie> fetchMovieDetails(String movieId) async {
    final jsonData = await movieService.fetchMovies(movieId);
    return Movie.fromJson(jsonData as Map<String, dynamic>); // Handle single movie object
  }
}
