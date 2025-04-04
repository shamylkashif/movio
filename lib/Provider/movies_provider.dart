import 'package:flutter/material.dart';

class MoviesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _watchedMovies = [];
  List<Map<String, dynamic>> _watchlistMovies = [];
  List<Map<String, dynamic>> _favoriteMovies = [];

  List<Map<String, dynamic>> get watchedMovies => _watchedMovies;
  List<Map<String, dynamic>> get watchlistMovies => _watchlistMovies;
  List<Map<String, dynamic>> get favoriteMovies => _favoriteMovies;

  int get watchedCount => _watchedMovies.length;
  int get watchlistCount => _watchlistMovies.length;

  void toggleWatched(BuildContext context ,Map<String, dynamic> movie) {
    if (_watchedMovies.contains(movie)) {
// Show message that it's already added
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} is already in Watched List!"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _watchedMovies.add(movie);
      _watchlistMovies.remove(movie); // Ensure it’s not in both lists

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} added to Watchlist!"),
          duration: Duration(seconds: 2),
        ),
      );
      notifyListeners();
    }
  }

  void toggleWatchlist(BuildContext context, Map<String, dynamic> movie) {
    if (_watchlistMovies.contains(movie)) {
      // Show message that it's already added
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} is already in Watchlist!"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _watchlistMovies.add(movie);
      _watchedMovies.remove(movie); // Remove from Watched list if present

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} added to Watchlist!"),
          duration: Duration(seconds: 2),
        ),
      );
      notifyListeners();
    }
  }

  void toggleFavorite(BuildContext context ,Map<String, dynamic> movie) {
    if (_favoriteMovies.contains(movie)) {
      // Show message that it's already added
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} is already in Favorites"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _favoriteMovies.add(movie);

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} added to Watchlist!"),
          duration: Duration(seconds: 2),
        ),
      );
      notifyListeners();
    }
  }

  bool isWatched(Map<String, dynamic> movie) => _watchedMovies.contains(movie);
  bool isInWatchlist(Map<String, dynamic> movie) => _watchlistMovies.contains(movie);
  bool isFavorite(Map<String, dynamic> movie) => _favoriteMovies.contains(movie);
}
