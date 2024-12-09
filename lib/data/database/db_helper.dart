import 'package:movie_app/data/model/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'app_database.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');

    await db.execute('''
  CREATE TABLE favorite_movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    movie_id TEXT,
    rank INTEGER,
    title TEXT,
    description TEXT,
    image TEXT,
    big_image TEXT,
    genre TEXT,
    thumbnail TEXT,
    rating TEXT,
    year INTEGER,
    imdb_id TEXT,
    imdb_link TEXT,
    trailer TEXT,
    trailer_embed_link TEXT,
    trailer_youtube_id TEXT,
    director TEXT,
    writers TEXT,
    FOREIGN KEY(user_id) REFERENCES users(id)
  )
''');
  }

  // User Sign Up
  Future<int> registerUser(String username, String password) async {
    final db = await database;
    return await db.insert(
      'users',
      {'username': username, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // User Login
  Future<Map<String, dynamic>?> loginUser(
      String username, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Add Favorite Movie
  Future<int> addFavoriteMovie(int userId, Movie movie) async {
    final db = await database;

    // Check if the movie already exists
    final existing = await db.query(
      'favorite_movies',
      where: 'user_id = ? AND movie_id = ?',
      whereArgs: [userId, movie.id],
    );

    if (existing.isNotEmpty) {
      return 0; // Skip adding if already exists
    }

    final movieData = {
      'user_id': userId,
      'movie_id': movie.id,
      'rank': movie.rank,
      'title': movie.title,
      'description': movie.description,
      'image': movie.image,
      'big_image': movie.bigImage,
      'genre': movie.genre.join(','), // Save as comma-separated string
      'thumbnail': movie.thumbnail,
      'rating': movie.rating,
      'year': movie.year,
      'imdb_id': movie.imdbId,
      'imdb_link': movie.imdbLink,
      'trailer': movie.trailer,
      'trailer_embed_link': movie.trailerEmbedLink,
      'trailer_youtube_id': movie.trailerYouTubeId,
      'director': movie.director.join(','),
      'writers': movie.writers.join(','),
    };

    return await db.insert(
      'favorite_movies',
      movieData,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // Get Favorite Movies for a User
  Future<List<Movie>> getFavoriteMovies(int userId) async {
    final db = await database;
    final result = await db.query(
      'favorite_movies',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return result.map((movie) {
      return Movie(
        rank: movie['rank'] as int,
        title: movie['title'] as String,
        description: movie['description'] as String,
        image: movie['image'] as String,
        bigImage: movie['big_image'] as String,
        genre: (movie['genre'] as String)
            .split(','), // Split comma-separated genre string
        thumbnail: movie['thumbnail'] as String,
        rating: movie['rating'] as String,
        id: movie['movie_id'] as String,
        year: movie['year'] as int,
        imdbId: movie['imdb_id'] as String,
        imdbLink: movie['imdb_link'] as String,
        trailer: movie['trailer'] as String, // Add trailer
        trailerEmbedLink:
            movie['trailer_embed_link'] as String, // Add trailer embed link
        trailerYouTubeId:
            movie['trailer_youtube_id'] as String, // Add trailer YouTube ID
        director: (movie['director'] as String)
            .split(','), // Split comma-separated director string
        writers: (movie['writers'] as String)
            .split(','), // Split comma-separated writers string
      );
    }).toList();
  }

  Future<int> removeFavoriteMovie(int userId, Movie movie) async {
    final db = await database;
    try {
      return await db.delete(
        'favorite_movies',
        where: 'user_id = ? AND movie_id = ?',
        whereArgs: [userId, movie.id],
      );
    } catch (e) {
      throw Exception('Failed to remove favorite movie: $e');
    }
  }
  
}
