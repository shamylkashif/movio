import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movio/screens/MainScreens/watchList.dart';

import '../screens/MainScreens/profile.dart';

class MoviesProvider with ChangeNotifier {
  List<Map<String, dynamic>> _watchedMovies = [];
  List<Map<String, dynamic>> _watchlistMovies = [];
  List<Map<String, dynamic>> _favoriteMovies = [];

  List<Map<String, dynamic>> get watchedMovies => _watchedMovies;
  List<Map<String, dynamic>> get watchlistMovies => _watchlistMovies;
  List<Map<String, dynamic>> get favoriteMovies => _favoriteMovies;

  int get watchedCount => _watchedMovies.length;
  int get watchlistCount => _watchlistMovies.length;
  int get favoriteCount => _favoriteMovies.length;

  void toggleWatched(BuildContext context, Map<String, dynamic> movie) async {
    // Check if the movie is already in WatchedList
    if (_watchedMovies.contains(movie)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} is already in watchedMovies"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _watchedMovies.add(movie);

      // Get user info from FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user?.uid ?? "Unknown"; // Get user ID

      try {
        // Fetch userName from Firestore only once
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users') // Users collection
            .doc(userId) // Document ID is the user ID (uid)
            .get();

        // Check if the user document exists and fetch the user name
        String userName = userDoc.exists ? userDoc['name'] ?? "Unknown" : "Unknown";

        // Prepare movie details to be saved
        String movieId = movie['id'].toString(); // Movie ID from TMDb data
        String title = movie['title'];
        String releaseDate = movie['release_date'];
        double voteAverage = movie['vote_average'];
        int duration = movie['runtime'] ?? 0; // Default to 0 if runtime is not available

        // Save movie details to Firestore (now only one Firestore call)
        await saveToWatchedMovies(
          userId: userId,
          userName: userName,  // Pass the userName fetched once
          movieId: movieId,
          title: title,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          duration: duration,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${movie['title']} added to WatchedMovies"),
            duration: Duration(seconds: 2),
          ),
        );
        notifyListeners();
      } catch (e) {
        // Handle any errors while fetching user data
        print("Error fetching user data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error adding movie to watchedMovies"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void toggleWatchlist(BuildContext context, Map<String, dynamic> movie) async {
    // Check if the movie is already in WatchList
    if (_watchlistMovies.contains(movie)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} is already in watchList"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _watchlistMovies.add(movie);

      // Get user info from FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user?.uid ?? "Unknown"; // Get user ID

      try {
        // Fetch userName from Firestore only once
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users') // Users collection
            .doc(userId) // Document ID is the user ID (uid)
            .get();

        // Check if the user document exists and fetch the user name
        String userName = userDoc.exists ? userDoc['name'] ?? "Unknown" : "Unknown";

        // Prepare movie details to be saved
        String movieId = movie['id'].toString(); // Movie ID from TMDb data
        String title = movie['title'];
        String releaseDate = movie['release_date'];
        double voteAverage = movie['vote_average'];
        int duration = movie['runtime'] ?? 0; // Default to 0 if runtime is not available

        // Save movie details to Firestore (now only one Firestore call)
        await saveToWatchList(
          userId: userId,
          userName: userName,  // Pass the userName fetched once
          movieId: movieId,
          title: title,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          duration: duration,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${movie['title']} added to watchList"),
            duration: Duration(seconds: 2),
          ),
        );
        notifyListeners();
      } catch (e) {
        // Handle any errors while fetching user data
        print("Error fetching user data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error adding movie to watchList"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void toggleFavorite(BuildContext context, Map<String, dynamic> movie) async {
    // Check if the movie is already in favorites
    if (_favoriteMovies.contains(movie)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${movie['title']} is already in Favorites"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      _favoriteMovies.add(movie);

      // Get user info from FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;
      String userId = user?.uid ?? "Unknown"; // Get user ID

      try {
        // Fetch userName from Firestore only once
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users') // Users collection
            .doc(userId) // Document ID is the user ID (uid)
            .get();

        // Check if the user document exists and fetch the user name
        String userName = userDoc.exists ? userDoc['name'] ?? "Unknown" : "Unknown";

        // Prepare movie details to be saved
        String movieId = movie['id'].toString(); // Movie ID from TMDb data
        String title = movie['title'];
        String releaseDate = movie['release_date'];
        double voteAverage = movie['vote_average'];
        int duration = movie['runtime'] ?? 0; // Default to 0 if runtime is not available

        // Save movie details to Firestore (now only one Firestore call)
        await saveMovieToFirestore(
          userId: userId,
          userName: userName,  // Pass the userName fetched once
          movieId: movieId,
          title: title,
          releaseDate: releaseDate,
          voteAverage: voteAverage,
          duration: duration,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${movie['title']} added to Favorites"),
            duration: Duration(seconds: 2),
          ),
        );
        notifyListeners();
      } catch (e) {
        // Handle any errors while fetching user data
        print("Error fetching user data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error adding movie to Favorites"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  bool isWatched(Map<String, dynamic> movie) => _watchedMovies.contains(movie);
  bool isInWatchlist(Map<String, dynamic> movie) => _watchlistMovies.contains(movie);
  bool isFavorite(Map<String, dynamic> movie) => _favoriteMovies.contains(movie);
}
