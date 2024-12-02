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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<FavoriteMovieCubit, FavoriteMovieState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FavoriteMoviesLoaded) {
              return ListView.builder(
                itemCount: state.favoriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = state.favoriteMovies[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      color: Colors.black54,
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: ListTile(
                        leading: Image.network(
                          movie.bigImage,
                          width: 100,
                          height: 100,
                        ),
                        title: Text(
                          movie.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              context
                                  .read<FavoriteMovieCubit>()
                                  .removeFavoriteMovie(userId, movie);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
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
