import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movie.dart';

class CategoryMoviesScreen extends StatelessWidget {
  final String category;
  final List<Movie> movies;

  const CategoryMoviesScreen(
      {super.key, required this.category, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed('');
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text('$category Movies'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 0.7, // ضبط نسبة العرض إلى الطول
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Column(
            mainAxisSize: MainAxisSize.min, // يسمح بالتحكم في حجم العمود
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
              ),
              const SizedBox(height: 15), // المسافة بين الصورة والعنوان
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
