import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic_layer/api_movie/api_cubit.dart';
import 'package:movie_app/presentation/widgets/movie_card.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Welcome back!'),
        elevation: theme.appBarTheme.elevation,
        centerTitle: theme.appBarTheme.centerTitle,
        scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.appBarTheme.iconTheme,
        actionsIconTheme: theme.appBarTheme.actionsIconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  hintText: 'Search Movie',
                  labelText: 'Search',
                  hintStyle: theme.inputDecorationTheme.hintStyle,
                  labelStyle: theme.inputDecorationTheme.labelStyle,
                  suffixIcon: Icon(
                    Icons.search,
                    color: theme.inputDecorationTheme.suffixIconColor,
                  ),
                  border: theme.inputDecorationTheme.border,
                  enabledBorder: theme.inputDecorationTheme.enabledBorder,
                  focusedBorder: theme.inputDecorationTheme.focusedBorder,
                ),
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                onChanged: (query) {
                  context.read<MoviesCubit>().searchMovies(query);
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<MoviesCubit, MoviesState>(
                builder: (context, state) {
                  if (state is MoviesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MoviesLoaded) {
                    final categorizedMovies = state.categorizedMovies;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListView(
                        children: categorizedMovies.entries.map((entry) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(entry.key,
                                        style: theme.textTheme.headlineMedium),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pushNamed(context, 'category',
                                          arguments: {
                                            'category': entry.key,
                                            'movies': entry.value,
                                          });
                                    },
                                    child: const Text(
                                      'See All',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Colors.grey, // Dynamic button color
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 220,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: entry.value.take(6).length,
                                  itemBuilder: (context, index) {
                                    final movie = entry.value[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, 'details',
                                            arguments: movie);
                                      },
                                      child: Container(
                                        width: 160,
                                        height: 140,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: theme
                                                .dividerColor, // Dynamic border color
                                            width: 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: theme.shadowColor,
                                              blurRadius: 2,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            movie.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  } else if (state is MoviesSearchLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.searchedMovies.length,
                        itemBuilder: (context, index) {
                          final movie = state.searchedMovies[index];
                          return MovieCard(
                              movie: movie); // Use your MovieCard widget here
                        },
                      ),
                    );
                  } else if (state is MoviesError) {
                    return Center(
                      child: Text(
                        state.errMessage,
                        style: TextStyle(
                            color: theme.textTheme.bodyLarge
                                ?.color), // Dynamic error text color
                      ),
                    );
                  }
                  return Center(
                    child: Text('Start browsing movies!',
                        style: TextStyle(
                            color: theme.textTheme.bodyLarge
                                ?.color)), // Dynamic text color
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
