import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDbService {
  static const String _apiKey = "2f51570f9c0a2142c2d7f3a934609f69";
  static const String _baseUrl = "https://api.themoviedb.org/3";

  // Fetch trending movies
  static Future<List<dynamic>> fetchTrendingMovies() async {
    final url = Uri.parse("$_baseUrl/trending/movie/week?api_key=$_apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["results"];
    } else {
      throw Exception("Failed to load movies");
    }
  }

  // Fetch recommended movies
  static Future<List<dynamic>> fetchRecommendedMovies() async {
    final url = Uri.parse("$_baseUrl/movie/popular?api_key=$_apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["results"];
    } else {
      throw Exception("Failed to load recommended movies");
    }
  }
}
