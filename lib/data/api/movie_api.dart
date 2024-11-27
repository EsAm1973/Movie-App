import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieService {
  Future<dynamic> fetchTopMovie() async {
    const String url = 'https://imdb-top-100-movies.p.rapidapi.com/';
    final Map<String, String> headers = {
      'x-rapidapi-key': '17a1a2336fmshf64e8a0181f053dp1ca554jsne3041c67cc23',
      'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com'
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Faild to load movies: ${response.statusCode}');
      }
    } catch (ex) {
      print('Error occurred: $ex');
    }
  }
}
