import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/repository/movie_api_repository.dart';

part 'api_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.movieApiRepository) : super(MoviesInitial());

  final MovieApiRepository movieApiRepository;
  Map<String, List<Movie>>? categorizedMovies;
  List<Movie>? categoryMovies;

  void fetchMovies() {
    emit(MoviesLoading());
    movieApiRepository.fetchTopMovie().then((movies) {
      final Map<String, List<Movie>> categoriesMovies = {
        'Drama': [],
        'Action': [],
        'Adventure': [],
        'Family': [],
        'Comedy': [],
      };
      for (var movie in movies) {
        for (var category in categoriesMovies.keys) {
          if (movie.genre.contains(category)) {
            categoriesMovies[category]?.add(movie);
          }
        }
      }
      emit(MoviesLoaded(categorizedMovies: categoriesMovies));
      categorizedMovies = categoriesMovies;
    }).catchError((error) {
      emit(MoviesError(errMessage: 'Failed to fetch: $error'));
    });
  }

  void fetchMoviesByCategory(String category) {
    emit(MoviesLoading());
    movieApiRepository.fetchTopMovie().then((movies) {
      final filteredMovies =
          movies.where((movie) => movie.genre.contains(category)).toList();
      emit(CategoryMoviesLoaded(category: category, movies: filteredMovies));
      categoryMovies = filteredMovies;
    }).catchError((error) {
      emit(MoviesError(errMessage: 'Failed to fetch movies: $error'));
    });
  }
}
