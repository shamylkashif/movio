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

  @override
  Widget build(BuildContext context) {
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
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movie: movie,)));
            },
            child: MovieCard(
              imageUrl: movie["imageUrl"],
              title: movie["title"],
              year: movie["year"],
              duration: movie["duration"],
              rating: movie["rating"],
              showAddIcon: true,
            ),
          );
        },
      ),
    );
  }
}
