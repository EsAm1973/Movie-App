import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 230,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Colors.black26,
              //     blurRadius: 2,
              //     offset: Offset(0, 4),
              //   ),
              // ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: movie.bigImage.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/loading.gif',
                      image: movie.bigImage,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/placeholder.png'),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
