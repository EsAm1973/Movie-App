import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/presentation/widgets/movie_card.dart';

class CategoryMoviesScreen extends StatelessWidget {
  final String category;
  final List<Movie> movies;

  const CategoryMoviesScreen(
      {super.key, required this.category, required this.movies});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('$category Movies'),
        elevation: theme.appBarTheme.elevation,
        scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.appBarTheme.iconTheme,
        actionsIconTheme: theme.appBarTheme.actionsIconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie);
        },
      ),
    );
  }
}
