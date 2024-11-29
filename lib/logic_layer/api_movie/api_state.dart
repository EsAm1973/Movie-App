part of 'api_cubit.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final Map<String, List<Movie>> categorizedMovies;

  MoviesLoaded({required this.categorizedMovies});
}

class CategoryMoviesLoaded extends MoviesState {
  final String category;
  final List<Movie> movies;

  CategoryMoviesLoaded({required this.category, required this.movies});
}

class MoviesError extends MoviesState {
  final String errMessage;

  MoviesError({required this.errMessage});
}
