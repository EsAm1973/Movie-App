part of 'api_cubit.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final Map<String, List<Movie>> categorizedMovies;

  MoviesLoaded({required this.categorizedMovies});
}

class MovieDetailsLoading extends MoviesState {}

class MovieDetailsLoaded extends MoviesState {
  final Movie movie;

  MovieDetailsLoaded({required this.movie});
}

class CategoryMoviesLoaded extends MoviesState {
  final String category;
  final List<Movie> movies;

  CategoryMoviesLoaded({required this.category, required this.movies});
}

class MoviesSearchLoaded extends MoviesState{
  final List<Movie> searchedMovies;

  MoviesSearchLoaded({required this.searchedMovies});
}

class MoviesError extends MoviesState {
  final String errMessage;

  MoviesError({required this.errMessage});
}
