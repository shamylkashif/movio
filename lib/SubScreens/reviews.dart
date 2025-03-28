import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movio/SubScreens/write-review.dart';
import 'package:movio/utils/app-colors.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  // Sample data for reviews (Will be fetched from database later)
  final List<Map<String, dynamic>> reviews = [
    {
      "username": "JohnDoe",
      "rating": 8.0,
      "headline": "Amazing Movie!",
      "review": "I really loved the cinematography and the acting was superb!",
      "containsSpoilers": false,
    },
    {
      "username": "MovieBuff99",
      "rating": 6.0,
      "headline": "Decent but predictable",
      "review": "The movie had some great moments, but the twist was too obvious.",
      "containsSpoilers": true,
    },
  ];

  final Map<int, bool> showSpoiler = {};

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteReview()));
                },
                child: Text('Write review', style: TextStyle(color: primaryRed, fontSize: 18),)),
          ),
        ],
      ),
      body: Padding(
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
                        style: TextStyle(color: white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      RatingBarIndicator(
                        rating: review['rating'],
                        unratedColor: white,
                        itemCount: 10,
                        itemSize: 18,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Headline
                  Text(
                    review['headline'],
                    style: TextStyle(color: primaryRed, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  // Spoiler Warning & Review
                  if (review['containsSpoilers'])
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showSpoiler[index] = !(showSpoiler[index] ?? false);
                        });
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: primaryRed,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("⚠️ Contains Spoilers", style: TextStyle(color: white)),
                          ),
                          const SizedBox(height: 4),
                          showSpoiler[index] ?? false
                              ? Text(
                            review['review'],
                            style: TextStyle(color: white, fontSize: 14),
                          )
                              : Container(
                            height: 40,
                            width: double.infinity,
                            color: Colors.grey.shade800,
                            alignment: Alignment.center,
                            child: Text(
                              "Tap to reveal spoilers",
                              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Text(
                      review['review'],
                      style: TextStyle(color: white, fontSize: 14),
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
