import 'package:flutter/material.dart';
import '../utils/app-colors.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String year;
  final String duration;
  final double rating;
  final bool showAddIcon; // New parameter to control icon visibility

  const MovieCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.year,
    required this.duration,
    required this.rating,
    this.showAddIcon = true, // Default is true for search results
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: white),
      ),
      child: Row(
        children: [
          // Movie Poster with Positioned Save Icon
          Stack(
            children: [
              // Movie Poster Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${imageUrl}",
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),

              // Conditionally show the "Add" button
              if (showAddIcon)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5), // Semi-transparent black
                    ),
                    child: const Icon(
                      Icons.add_circle_outline_outlined,
                      color: white,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),

          // Movie Details (Centered)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centering content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$year  •  $duration",
                  style: const TextStyle(color: lightGray),
                ),
                const SizedBox(height: 8),

                // Star Rating
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(color: white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
