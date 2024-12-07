import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: const Text('MOVIE APP'),
        elevation: theme.appBarTheme.elevation,
        centerTitle: true,
        scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
        backgroundColor: theme.appBarTheme.backgroundColor,
        iconTheme: theme.appBarTheme.iconTheme,
        actionsIconTheme: theme.appBarTheme.actionsIconTheme,
        titleTextStyle: GoogleFonts.robotoCondensed(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 204, 20, 7)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search TextField
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
                  } else if (state is MoviesSearchLoaded) {
                    // Display search results
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
                          return MovieCard(movie: movie);
                        },
                      ),
                    );
                  } else if (state is MoviesLoaded) {
                    final trendingMovies =
                        state.categorizedMovies['Trending'] ?? [];
                    return ListView(
                      children: [
                        if (trendingMovies.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text('Trending Movies',
                                    style: theme.textTheme.headlineMedium),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: CarouselSlider.builder(
                                  itemCount: trendingMovies.length,
                                  options: CarouselOptions(
                                    height: 230,
                                    autoPlay: true,
                                    viewportFraction: 0.50,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlayAnimationDuration:
                                        const Duration(seconds: 1),
                                    enlargeCenterPage: true,
                                    pageSnapping: true,
                                  ),
                                  itemBuilder: (context, index, pageViewIndex) {
                                    final movie = trendingMovies[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          'details',
                                          arguments: movie,
                                        );
                                      },
                                      child: Container(
                                        width: 180,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: theme.shadowColor,
                                              blurRadius: 4,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: movie.bigImage.isNotEmpty
                                              ? FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/loading.gif',
                                                  image: movie.bigImage,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/placeholder.png'),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        // Categories Section
                        ...state.categorizedMovies.entries.map((entry) {
                          if (entry.key == 'Trending') {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Text('${entry.key} Movies',
                                        style: theme.textTheme.headlineMedium),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        'category',
                                        arguments: {
                                          'category': entry.key,
                                          'movies': entry.value,
                                        },
                                      );
                                    },
                                    child: Text(
                                      'See All',
                                      style: theme.textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 210,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: entry.value.take(6).length,
                                  itemBuilder: (context, index) {
                                    final movie = entry.value[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          'details',
                                          arguments: movie,
                                        );
                                      },
                                      child: Container(
                                        width: 160,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: movie.bigImage.isNotEmpty
                                              ? FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'assets/loading.gif',
                                                  image: movie.bigImage,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/placeholder.png'),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }),
                      ],
                    );
                  } else if (state is MoviesError) {
                    // Display Error
                    return Center(
                      child: Text(
                        state.errMessage,
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }
                  return  Center(
                    child: Text('Start browsing movies!',
                        style: theme.textTheme.bodyMedium),
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
