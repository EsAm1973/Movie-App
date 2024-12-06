import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic_layer/favorite_movie/favorite_movie_cubit.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late UserDataCubit userCubit;
  late int userId;
  @override
  void initState() {
    super.initState();
    userCubit = context.read<UserDataCubit>();
    userId = userCubit.state!.id;
    context.read<FavoriteMovieCubit>().fetchFavoriteMovies(userId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Favorite Movies'),
          elevation: theme.appBarTheme.elevation,
          scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
          backgroundColor: theme.appBarTheme.backgroundColor,
          iconTheme: theme.appBarTheme.iconTheme,
          actionsIconTheme: theme.appBarTheme.actionsIconTheme,
          titleTextStyle: theme.appBarTheme.titleTextStyle,
          centerTitle: true,
        ),
        body: BlocBuilder<FavoriteMovieCubit, FavoriteMovieState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteMoviesLoaded) {
              if (state.favoriteMovies.isEmpty) {
                return Center(
                    child: Text('No favorite movies yet.',
                        style: theme.textTheme.bodyLarge));
              }
              return ListView.builder(
                itemCount: state.favoriteMovies.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                itemBuilder: (context, index) {
                  final movie = state.favoriteMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'details', arguments: movie);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isDarkTheme
                                  ? [
                                      Colors.black,
                                      Colors.grey.shade700,
                                    ] // Colors for dark theme
                                  : [
                                      Colors.white70,
                                      Colors.white54
                                    ], // Colors for light theme
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    movie.bigImage,
                                    width: 100, // Adjusted width
                                    height: 150, // Adjusted height
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          movie.title,
                                          style: theme.textTheme.headlineSmall),
                                      const SizedBox(height: 8),
                                      Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          movie.genre.join(', '),
                                          style: theme.textTheme.bodyMedium),
                                      const SizedBox(height: 8),
                                      Text('${movie.year}',
                                          style: theme.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<FavoriteMovieCubit>()
                                        .removeFavoriteMovie(userId, movie);
                                  },
                                  icon: const Icon(
                                    size: 28,
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is FavoriteMoviesError) {
              return Text(state.errMessage);
            } else {
              return const Text('No favorite movies yet.');
            }
          },
        ),
      ),
    );
  }
}
