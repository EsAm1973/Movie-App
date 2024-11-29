import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/api/movie_api.dart';
import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/repository/auth_user_repository.dart';
import 'package:movie_app/data/repository/movie_api_repository.dart';
import 'package:movie_app/logic_layer/api_movie/api_cubit.dart';
import 'package:movie_app/logic_layer/auth_user/auth_cubit.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';
import 'package:movie_app/presentation/screens/homepage_screen.dart';
import 'package:movie_app/presentation/screens/login_screen.dart';
import 'package:movie_app/presentation/screens/signup_screen.dart';

class AppRouting {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => UserDataCubit(),
                    ),
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
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UserDataCubit(),
              ),
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
            builder: (_) => BlocProvider(
                  create: (context) => MoviesCubit(
                      MovieApiRepository(movieService: MovieService()))
                    ..fetchMovies(),
                  child: const HomepageScreen(),
                ));
      // case 'category':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           CategoryMoviesLoaded(category: category, movies: movies));
      default:
        return null;
    }
  }
}
