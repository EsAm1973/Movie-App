import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app_routing.dart';
import 'package:movie_app/logic_layer/theme_cubit/theme_cubit.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemeCubit(),
      ),
      BlocProvider(
        create: (context) => UserDataCubit(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouting appRouting = AppRouting();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        ThemeData appTheme;

        if (themeState is ThemeChanged) {
          appTheme = themeState.themeData;
        } else {
          // Default fallback if ThemeCubit doesn't emit a ThemeChanged state
          appTheme = ThemeCubit.lightTheme;
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movie App',
          theme: appTheme,
          onGenerateRoute: appRouting.onGenerateRoute,
        );
      },
    );
  }
}
