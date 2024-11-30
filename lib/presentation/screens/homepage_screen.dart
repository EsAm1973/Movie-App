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
  void initState() {
    super.initState();
    BlocProvider.of<MoviesCubit>(context).fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Welcome back!'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
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
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelText: 'Search',
                  labelStyle: const TextStyle(color: Colors.grey),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
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
                                    child: Text(
                                      entry.key,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
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
                          return MovieCard(movie: movie);
                        },
                      ),
                    );
                  } else if (state is MoviesError) {
                    return Center(
                      child: Text(
                        state.errMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return const Center(
                    child: Text('Start browsing movies!',
                        style: TextStyle(color: Colors.white)),
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
