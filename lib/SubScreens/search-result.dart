import 'package:flutter/material.dart';
import 'package:movio/SubScreens/movie-description.dart';
import 'package:movio/utils/app-colors.dart';

import '../widgets/movie-card.dart';

class SearchResultsScreen extends StatefulWidget {
  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final List<Map<String, dynamic>> movies = [
    {
      "imageUrl": "assets/after.webp", // Replace with actual URL
      "title": "THE FALL GUY",
      "year": "2024",
      "duration": "2h 6m",
      "rating": 6.9,
    },
    {
      "imageUrl": "assets/alone.webp",
      "title": "YOUNG LION OF THE WEST",
      "year": "2024",
      "duration": "1h 33m",
      "rating": 8.3
    },
    {
      "imageUrl": "assets/CivilWar.jpeg",
      "title": "FOOL ME ONCE, REVENGE ON YOU",
      "year": "2024",
      "duration": "",
      "rating": 7.0
    },
    {
      "imageUrl": "assets/TheOrder.jpg",
      "title": "HELL CITY",
      "year": "2024",
      "duration": "1h 30m",
      "rating": 0.0
    },
  ];

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
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsScreen(movie: {},)));
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
