import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app_routing.dart';
import 'package:movie_app/logic_layer/theme_cubit/theme_cubit.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemeCubit()..loadTheme(),
      ),
      BlocProvider(
        create: (context) => UserDataCubit(),
      ),
    ],
    child: MyApp(
      isLoggedIn: isLoggedIn,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouting appRouting = AppRouting();
  final bool isLoggedIn;
  MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        ThemeData appTheme;

        if (themeState is ThemeChanged) {
          appTheme = themeState.themeData;
        } else {
          appTheme = ThemeCubit.darkTheme;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: appTheme,
          initialRoute: isLoggedIn ? 'navbar' : '/',
          onGenerateRoute: appRouting.onGenerateRoute,
        );
      },
    );
  }
}
