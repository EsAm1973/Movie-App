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

  void fetchMovies() {
    if (categorizedMovies != null) {
      // Re-emit the cached state if movies are already fetched
      emit(MoviesLoaded(categorizedMovies: categorizedMovies!));
      return;
    }

    emit(MoviesLoading());
    movieApiRepository.fetchTopMovies().then((movies) {
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
      categorizedMovies = categoriesMovies;
      emit(MoviesLoaded(categorizedMovies: categoriesMovies));
    }).catchError((error) {
      emit(MoviesError(errMessage: 'Failed to fetch: $error'));
    });
  }

  void fetchMovieDetails(String movieId) {
    emit(MovieDetailsLoading());
    movieApiRepository.fetchMovieDetails(movieId).then((movie) {
      emit(MovieDetailsLoaded(movie: movie));
    }).catchError((error) {
      emit(MoviesError(errMessage: 'Failed to fetch movie details: $error'));
    });
  }

  void searchMovies(String query) {
    if (query.isEmpty) {
      if (categorizedMovies != null) {
        emit(MoviesLoaded(categorizedMovies: categorizedMovies!));
      }
      return;
    }
    final List<Movie> searchedMovies = [];
    categorizedMovies?.values.forEach((movieList) {
      searchedMovies.addAll(
        movieList.where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase())),
      );
    });
    emit(MoviesSearchLoaded(searchedMovies: searchedMovies));
  }
}
