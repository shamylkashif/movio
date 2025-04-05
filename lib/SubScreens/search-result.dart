import 'package:flutter/material.dart';
import 'package:movio/SubScreens/movie-description.dart';
import 'package:movio/utils/app-colors.dart';

import '../widgets/movie-card.dart';

class SearchResultsScreen extends StatefulWidget {
  final List<dynamic> results;

  const SearchResultsScreen({required this.results});
  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {

  String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return "${hours}h ${mins}m";
  }

  @override
  Widget build(BuildContext context) {
    print("Search results length: ${widget.results.length}"); // ✅ Log this
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: Icon(Icons.arrow_back_ios_new,color: white,)),
        title: const Text("Search Results", style: TextStyle(color: white)),
      ),
      body: ListView.builder(
        itemCount: widget.results.length,
        itemBuilder: (context, index) {
          final movie = widget.results[index];

          String posterPath = movie['poster_path'] ?? '';
          String imageUrl = posterPath.isNotEmpty
              ? 'https://image.tmdb.org/t/p/w500$posterPath'
              : 'https://via.placeholder.com/500'; // Use placeholder if no poster
          final String title = movie["title"] ?? "Unknown";
          final String year = movie["release_date"] != null
              ? (movie["release_date"] as String).split("-")[0]
              : "N/A";
          final int duration = movie["runtime"] ?? 0;
          final double rating = (movie["vote_average"] as num?)?.toDouble() ?? 0.0;

          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movie: movie,)));
            },
            child: MovieCard(
              imageUrl: imageUrl,
              title: title,
              year: year,
              duration: formatDuration(duration),
              rating: rating,
              showAddIcon: false,
            ),
          );
        },
      ),
    );
  }
}
