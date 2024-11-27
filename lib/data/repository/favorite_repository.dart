import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/model/movie.dart';

class FavoriteRepository {
  final DatabaseHelper _databaseHelper;

  FavoriteRepository({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  Future<int> addFavoriteMovie(int userId, Movie movie) async {
    try {
      if (userId <= 0 || movie == null) {
        throw ArgumentError('Invalid userId or movie data');
      }
      return await _databaseHelper.addFavoriteMovie(userId, movie);
    } catch (e) {
      throw Exception('Failed to add favorite movie: $e');
    }
  }

  Future<List<Movie>> getFavoriteMovies(int userId) async {
    try {
      if (userId <= 0) {
        throw ArgumentError('Invalid userId');
      }
      return await _databaseHelper.getFavoriteMovies(userId);
    } catch (e) {
      throw Exception('Failed to fetch favorite movies: $e');
    }
  }

  Future<int> removeFavoriteMovie(int userId, Movie movie) async {
    try {
      if (userId <= 0 || movie == null) {
        throw ArgumentError('Invalid userId or movieId.');
      }
      return await _databaseHelper.removeFavoriteMovie(userId, movie);
    } catch (e) {
      throw Exception('Failed to remove favorite movie: $e');
    }
  }
}
