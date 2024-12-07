import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/themes/appbar_theme.dart';
import 'package:movie_app/themes/navigation_bar_theme.dart';
import 'package:movie_app/themes/text_theme.dart';
import 'package:movie_app/themes/textfield_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeChanged(darkTheme));

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    inputDecorationTheme: TTextFormField.lightInputDecoration,
    appBarTheme: AAppBarTheme.lightAppBar,
    cardColor: Colors.grey.shade200,
    navigationBarTheme: NNavigationBarTheme.lightNavigationBar,
    unselectedWidgetColor: Colors.grey.shade500,
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    inputDecorationTheme: TTextFormField.darkInputDecoration,
    appBarTheme: AAppBarTheme.darkAppBar,
    cardColor: Colors.grey.shade900,
    navigationBarTheme: NNavigationBarTheme.darkNavigationBar,
    unselectedWidgetColor: Colors.grey,
  );

  void toggleTheme() {
    if (state is ThemeChanged) {
      final currentTheme = (state as ThemeChanged).themeData;
      emit(ThemeChanged(currentTheme.brightness == Brightness.light
          ? darkTheme
          : lightTheme));
    }
  }
}
