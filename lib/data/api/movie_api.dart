import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieService {
  Future<List<dynamic>> fetchTopMovie() async {
    const String url = 'https://imdb-top-100-movies.p.rapidapi.com/';
    final Map<String, String> headers = {
      'x-rapidapi-key': '565ec57026msh6c3bb34b0573129p16d12bjsn6a69cd97d3a1',
      'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> movies = jsonDecode(response.body) as List<dynamic>;
        return movies;
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (ex) {
      throw Exception('Error occurred while fetching movies: $ex');
    }
  }
}
