import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/repository/favorite_repository.dart';

part 'favorite_movie_state.dart';

class FavoriteMovieCubit extends Cubit<FavoriteMovieState> {
  final FavoriteRepository _favoriteRepository;
  FavoriteMovieCubit({required FavoriteRepository favoriteRepository})
      : _favoriteRepository = favoriteRepository,
        super(FavoriteMovieInitial());

  void fetchFavoriteMovies(int userId) async {
    emit(FavoriteMoviesLoading());
    try {
      final movies = await _favoriteRepository.getFavoriteMovies(userId);
      emit(FavoriteMoviesLoaded(favoriteMovies: movies));
    } catch (e) {
      emit(FavoriteMoviesError(
          errMessage: 'Error fetching favorite movies: $e'));
    }
  }

  void addFavoriteMovie(int userId, Movie movie) {
    emit(FavoriteMoviesLoading());
    _favoriteRepository.addFavoriteMovie(userId, movie).then((_) {
      emit(FavoriteMovieAdded(movie: movie));
      fetchFavoriteMovies(userId);
    }).catchError((error) {
      emit(FavoriteMoviesError(
          errMessage: 'Faild to add favorite movie: $error'));
    });
  }

  void removeFavoriteMovie(int userId, Movie movie) {
    emit(FavoriteMoviesLoading());
    _favoriteRepository.removeFavoriteMovie(userId, movie).then((_) {
      emit(FavoriteMovieRemoved(movie: movie));
      fetchFavoriteMovies(userId);
    }).catchError((error) {
      emit(FavoriteMoviesError(
          errMessage: 'Faild to remove favorite movie: $error'));
    });
  }
}
