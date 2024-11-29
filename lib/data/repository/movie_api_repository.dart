import 'package:movie_app/data/api/movie_api.dart';
import 'package:movie_app/data/model/movie.dart';

class MovieApiRepository {
  final MovieService movieService;

  MovieApiRepository({required this.movieService});

  Future<List<Movie>> fetchTopMovie() async {
    final jsonData = await movieService.fetchTopMovie();
    return jsonData.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}
