import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:movio/utils/app-colors.dart';

class Reviews extends StatefulWidget {
  final int movieId;

  const Reviews({super.key, required this.movieId});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List<Map<String, dynamic>> reviews = [];
  final Map<int, bool> showSpoiler = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    final apiKey = "2f51570f9c0a2142c2d7f3a934609f69"; // Replace with your actual TMDB API key
    final url =
        'https://api.themoviedb.org/3/movie/${widget.movieId}/reviews?api_key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List results = data['results'];

        final fetchedReviews = results.map<Map<String, dynamic>>((review) {
          final content = review['content'] ?? '';
          return {
            "username": review['author'] ?? "Anonymous",
            "rating":
            review['author_details']?['rating']?.toDouble() ?? 0.0,
            "headline": "Review by ${review['author'] ?? "Anonymous"}",
            "review": content,
            // Basic spoiler detection (can improve later)
            "containsSpoilers": content.toLowerCase().contains("spoiler"),
          };
        }).toList();

        setState(() {
          reviews = fetchedReviews;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        debugPrint("Failed to fetch reviews: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: white),
        ),
        title: Text("Reviews", style: TextStyle(color: white)),

      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : reviews.isEmpty
          ? Center(
        child: Text(
          "No reviews available",
          style: TextStyle(color: white, fontSize: 16),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['username'],
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      RatingBarIndicator(
                        rating: review['rating'],
                        unratedColor: white,
                        itemCount: 10,
                        itemSize: 18,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.amber),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Headline
                  Text(
                    review['headline'],
                    style: TextStyle(
                        color: primaryRed,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  // Spoiler Warning & Review
                  if (review['containsSpoilers'])
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showSpoiler[index] =
                          !(showSpoiler[index] ?? false);
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: primaryRed,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("⚠️ Contains Spoilers",
                                style: TextStyle(color: white)),
                          ),
                          const SizedBox(height: 4),
                          showSpoiler[index] ?? false
                              ? Text(
                            review['review'],
                            style: TextStyle(
                                color: white, fontSize: 14),
                          )
                              : Container(
                            height: 40,
                            width: double.infinity,
                            color: Colors.grey.shade800,
                            alignment: Alignment.center,
                            child: Text(
                              "Tap to reveal spoilers",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Text(
                      review['review'],
                      style:
                      TextStyle(color: white, fontSize: 14),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
