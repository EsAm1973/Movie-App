import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/api/movie_api.dart';
import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/repository/auth_user_repository.dart';
import 'package:movie_app/data/repository/favorite_repository.dart';
import 'package:movie_app/data/repository/movie_api_repository.dart';
import 'package:movie_app/logic_layer/api_movie/api_cubit.dart';
import 'package:movie_app/logic_layer/auth_user/auth_cubit.dart';
import 'package:movie_app/logic_layer/favorite_movie/favorite_movie_cubit.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';
import 'package:movie_app/presentation/screens/category_movies_screen.dart';
import 'package:movie_app/presentation/screens/favorite_screen.dart';
import 'package:movie_app/presentation/screens/homepage_screen.dart';
import 'package:movie_app/presentation/screens/login_screen.dart';
import 'package:movie_app/presentation/screens/movie_details.dart';
import 'package:movie_app/presentation/screens/signup_screen.dart';

class AppRouting {
  final MoviesCubit moviesCubit =
      MoviesCubit(MovieApiRepository(movieService: MovieService()));
  final FavoriteMovieCubit favoriteMovieCubit = FavoriteMovieCubit(
      favoriteRepository: FavoriteRepository(databaseHelper: DatabaseHelper()));
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<UserDataCubit>()),
                    BlocProvider(
                      create: (context) => AuthCubit(
                          userDataCubit: context.read<UserDataCubit>(),
                          authUserRepository: AuthUserRepository(
                              databaseHelper: DatabaseHelper())),
                    ),
                  ],
                  child: const LoginScreen(),
                ));

      case 'register':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<UserDataCubit>()),
              BlocProvider(
                create: (context) => AuthCubit(
                  userDataCubit: context.read<UserDataCubit>(),
                  authUserRepository: AuthUserRepository(
                    databaseHelper: DatabaseHelper(),
                  ),
                ),
              ),
            ],
            child: const SignupScreen(),
          ),
        );

      case 'home':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<UserDataCubit>()),
                    BlocProvider(
                        create: (context) => MoviesCubit(
                            MovieApiRepository(movieService: MovieService()))
                          ..fetchMovies())
                  ],
                  child: const HomepageScreen(),
                ));

      case 'category':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => BlocProvider<MoviesCubit>.value(
                  value: moviesCubit,
                  child: CategoryMoviesScreen(
                    category: args['category'] as String,
                    movies: args['movies'] as List<Movie>,
                  ),
                ));

      case 'details':
        final args = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<UserDataCubit>()),
              BlocProvider<MoviesCubit>.value(
                value: moviesCubit,
              ),
              BlocProvider<FavoriteMovieCubit>.value(value: favoriteMovieCubit),
            ],
            child: MovieDetails(movie: args),
          ),
        );

      case 'favorite':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: context.read<UserDataCubit>()),
                    BlocProvider<FavoriteMovieCubit>.value(
                        value: favoriteMovieCubit),
                  ],
                  child: const FavoriteScreen(),
                ));
      default:
        return null;
    }
  }
}
