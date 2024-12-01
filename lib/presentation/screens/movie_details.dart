import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movie});
  final Movie movie;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
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
              child: IconButton(
                icon: const Icon(Icons.favorite_border,
                    size: 30, color: Colors.white),
                onPressed: () {},
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
