import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/logic_layer/favorite_movie/favorite_movie_cubit.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movie});
  final Movie movie;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
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
      body: Column(
        children: [
          Stack(children: [
            SizedBox(
              width: double.infinity,
              height: 600,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: Image.network(
                  widget.movie.bigImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    size: 30, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: 20,
              right: 16,
              child: BlocBuilder<FavoriteMovieCubit, FavoriteMovieState>(
                builder: (context, state) {
                  final cubit = context.read<FavoriteMovieCubit>();

                  bool isFavorite = false;
                  if (state is FavoriteMoviesLoaded) {
                    isFavorite = state.favoriteMovies
                        .any((m) => m.id == widget.movie.id);
                  }

                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        cubit.removeFavoriteMovie(userId, widget.movie);
                      } else {
                        cubit.addFavoriteMovie(userId, widget.movie);
                      }
                    },
                  );
                },
              ),
            ),
            Positioned(
                bottom: 40,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.movie.title,
                      style: TextStyle(
                          color: Colors.grey.shade100,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.movie.year.toString(),
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Positioned(
              bottom: 40,
              right: 16,
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.white70, size: 24),
                  const SizedBox(width: 4),
                  Text(
                    widget.movie.rating.toString(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  widget.movie.description,
                  style: const TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        backgroundColor: Colors.deepPurple.shade500,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    label: const Text(
                      'Wathch Trailer',
                      style: TextStyle(fontSize: 18),
                    ),
                    icon: const Icon(
                      Icons.play_arrow_outlined,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
