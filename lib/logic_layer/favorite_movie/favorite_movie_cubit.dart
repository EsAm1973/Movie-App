import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_movie_state.dart';

class FavoriteMovieCubit extends Cubit<FavoriteMovieState> {
  FavoriteMovieCubit() : super(FavoriteMovieInitial());
}
