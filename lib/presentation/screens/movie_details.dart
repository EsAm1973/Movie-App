import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/logic_layer/api_movie/api_cubit.dart';
import 'package:movie_app/logic_layer/favorite_movie/favorite_movie_cubit.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

    // Fetch movie details using the movieId
    context.read<MoviesCubit>().fetchMovieDetails(widget.movie.id);
  }

  void _showTrailer(String trailerYouTubeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: trailerYouTubeId,
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  ),
                  showVideoProgressIndicator: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                  child: BlocBuilder<MoviesCubit, MoviesState>(
                    builder: (context, state) {
                      if (state is MovieDetailsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MovieDetailsLoaded) {
                        final movie = state.movie;
                        return Image.network(
                          movie.bigImage,
                          fit: BoxFit.cover,
                        );
                      } else if (state is MoviesError) {
                        return Center(child: Text(state.errMessage));
                      }
                      return const Center(child: Text('Error loading movie.'));
                    },
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
                child: BlocBuilder<MoviesCubit, MoviesState>(
                  builder: (context, state) {
                    if (state is MovieDetailsLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.movie.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade100,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.movie.year.toString(),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }
                    // Placeholder if no movie details are loaded
                    return const SizedBox();
                  },
                ),
              ),
            ]),
            BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                if (state is MovieDetailsLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          state.movie.description,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white70),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: Colors.deepPurple.shade500,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              _showTrailer(state.movie.trailerYouTubeId);
                            },
                            label: const Text(
                              'Watch Trailer',
                              style: TextStyle(fontSize: 18),
                            ),
                            icon: const Icon(
                              Icons.play_arrow_outlined,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox(); // Placeholder when movie details aren't loaded
              },
            ),
          ],
        ),
      ),
    );
  }
}
