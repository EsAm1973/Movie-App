import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic_layer/api_movie/api_cubit.dart';
import 'package:movie_app/presentation/screens/category_movies_screen.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: BlocBuilder<MoviesCubit, MoviesState>(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                  fontSize: 24,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              BlocProvider.of<MoviesCubit>(context)
                                  .fetchMoviesByCategory(entry.key);
                            },
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 260,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: entry.value.take(6).length,
                          itemBuilder: (context, index) {
                            final movie = entry.value[index];
                            return Container(
                              width: 190,
                              height: 170,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  movie.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }).toList(),
              ),
            );
          } else if (state is CategoryMoviesLoaded) {
            return CategoryMoviesScreen(
              category: state.category,
              movies: state.movies,
            );
          } else if (state is MoviesError) {
            return Center(
              child: Text(state.errMessage),
            );
          }
          return const Center(
            child: Text('Start browsing movies!'),
          );
        },
      )),
    );
  }
}
