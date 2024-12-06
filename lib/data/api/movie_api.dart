import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieService {
  Future<dynamic> fetchMovies(String endpoint) async {
    final String url = 'https://imdb-top-100-movies.p.rapidapi.com/$endpoint';
    final Map<String, String> headers = {
      'x-rapidapi-key': '688d6697cbmsh258437a8d0222efp13cabajsna1fa83b5be6b',
      'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return decodedData; // Return the raw decoded data
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (ex) {
      throw Exception('Error occurred while fetching data: $ex');
    }
  }
}
