part of 'favorite_movie_cubit.dart';

@immutable
sealed class FavoriteMovieState {}

final class FavoriteMovieInitial extends FavoriteMovieState {}

final class FavoriteMoviesLoading extends FavoriteMovieState {}

final class FavoriteMoviesLoaded extends FavoriteMovieState {
  final List<Movie> favoriteMovies;

  FavoriteMoviesLoaded({required this.favoriteMovies});
}

final class FavoriteMoviesError extends FavoriteMovieState {
  final String errMessage;

  FavoriteMoviesError({required this.errMessage});
}

final class FavoriteMovieAdded extends FavoriteMovieState {
  final Movie movie;

  FavoriteMovieAdded({required this.movie});
}

final class FavoriteMovieRemoved extends FavoriteMovieState {
  final Movie movie;

  FavoriteMovieRemoved({required this.movie});
}
