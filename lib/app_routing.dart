import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/database/db_helper.dart';
import 'package:movie_app/data/repository/auth_user_repository.dart';
import 'package:movie_app/logic_layer/auth_user/auth_cubit.dart';
import 'package:movie_app/presentation/screens/homepage_screen.dart';
import 'package:movie_app/presentation/screens/login_screen.dart';
import 'package:movie_app/presentation/screens/signup_screen.dart';

class AppRouting {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case 'register':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(
              authUserRepository: AuthUserRepository(
                databaseHelper: DatabaseHelper(),
              ),
            ),
            child: const SignupScreen(),
          ),
        );
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomepageScreen());
      default:
        return null;
    }
  }
}
