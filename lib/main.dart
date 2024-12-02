import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/app_routing.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => UserDataCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouting appRouting = AppRouting();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: appRouting.onGenerateRoute,
    );
  }
}
