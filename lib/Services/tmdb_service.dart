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

  // Fetch movie details by ID
// In TMDbService
  // Fetch genres dynamically from TMDb
  static Future<Map<String, int>> fetchGenres() async {
    final response = await http.get(Uri.parse('$_baseUrl/genre/movie/list?api_key=$_apiKey&language=en-US'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Map<String, int> genreMap = {};
      for (var genre in data['genres']) {
        genreMap[genre['name']] = genre['id'];
      }
      return genreMap; // Return mapping of genre names to IDs
    } else {
      throw Exception('Failed to load genres');
    }
  }

  // Search movies based on filters
  static Future<List<Map<String, dynamic>>> searchMovies({
    required String type,
    required int rating,
    required String year,
    required List<int> genres, // Genre IDs
  }) async {
    final genreParam = genres.isEmpty ? '' : '&with_genres=${genres.join(',')}'; // Join genre IDs if selected
    final ratingParam = rating > 0 ? '&vote_average.gte=$rating' : ''; // Apply rating filter
    final yearParam = year.isNotEmpty ? '&primary_release_year=$year' : ''; // Apply year filter
    final typeParam = type != 'All' ? '&media_type=$type' : ''; // Apply type filter if selected

    final url = '$_baseUrl/discover/movie?api_key=$_apiKey&language=en-US' +
        genreParam + ratingParam + yearParam + typeParam;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load movies');
    }
  }

  static Future<List<Map<String, dynamic>>> searchMoviesByName({
    required String query,
  }) async {
    // Encode the query to ensure it's URL-safe
    final encodedQuery = Uri.encodeComponent(query);

    // Construct the URL for the search API using the encoded query
    final url = '$_baseUrl/search/movie?api_key=$_apiKey&language=en-US&query=$encodedQuery';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['results']);
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load movies');
    }
  }

}
