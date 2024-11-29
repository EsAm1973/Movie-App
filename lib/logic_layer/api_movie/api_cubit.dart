import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/repository/movie_api_repository.dart';

part 'api_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.movieApiRepository) : super(MoviesInitial());

  final MovieApiRepository movieApiRepository;

  Future<void> fetchMovies() async {
    emit(MoviesLoading());
    try {
      final List<Movie> movies = await movieApiRepository.fetchTopMovie();
      final Map<String, List<Movie>> categorizedMovies = {
        'Drama': [],
        'Action': [],
        'Adventure': [],
        'Family': [],
        'Comedy': [],
      };
      for (var movie in movies) {
        for (var category in categorizedMovies.keys) {
          if (movie.genre.contains(category)) {
            categorizedMovies[category]?.add(movie);
          }
        }
      }
      emit(MoviesLoaded(categorizedMovies: categorizedMovies));
    } catch (e) {
      emit(MoviesError(errMessage: 'Faild to fetch: $e'));
    }
  }

  Future<void> fetchMoviesByCategory(String category) async {
    emit(MoviesLoading());
    try {
      final List<Movie> movies = await movieApiRepository.fetchTopMovie();
      final categoryMovies =
          movies.where((movie) => movie.genre.contains(category)).toList();
      emit(CategoryMoviesLoaded(category: category, movies: categoryMovies));
    } catch (e) {
      emit(MoviesError(errMessage: 'Falid to fetch movies: $e'));
    }
  }
}
