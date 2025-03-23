import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movio/SubScreens/reviews.dart';
import 'package:movio/utils/app-colors.dart';

class WriteReview extends StatefulWidget {
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  double rating = 0;
  String? selectedSpoilerOption;
  TextEditingController reviewController = TextEditingController();
  TextEditingController headlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: white),
        ),
        title: const Text("Write your review", style: TextStyle(color: white)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: MediaQuery.removeViewInsets(
                context: context,
                removeBottom: true, // Removes default padding caused by the keyboard
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Poster & Title
                      Row(
                        children: [
                          ClipRRect(
                            child: Image.asset(
                              "assets/TheOrder.jpg",
                              width: 80,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Red One",
                                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(2024)",
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 16),

                      // Your Rating
                      const Text("Your Rating",
                          style: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      RatingBar.builder(
                        initialRating: rating,
                        minRating: 0,
                        maxRating: 10,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 10,
                        itemSize: 28,
                        unratedColor: white,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (newRating) {
                          setState(() {
                            rating = newRating;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Your Review
                      const Text("Your Review",
                          style: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextField(
                        cursorColor: white,
                        controller: headlineController,
                        style: const TextStyle(color: white),
                        decoration: InputDecoration(
                          hintText: "Write a headline for your review here",
                          hintStyle: TextStyle(color: lightGray),
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.only(left: 150),
                        child: RichText(
                          text: TextSpan(
                            text: 'Maximum Characters  ',
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '600',
                                  style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),

                      // Review Text Area
                      TextField(
                        controller:reviewController,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: white,
                        decoration: InputDecoration(
                          hintText: "Write your detailed review...",
                          hintStyle: const TextStyle(color: lightGray),
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Does this review contain spoilers?
                      const Text("Does this review contain spoilers?",
                          style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Radio<String>(
                            value: "Yes",
                            groupValue: selectedSpoilerOption,
                            activeColor: primaryRed,
                            onChanged: (value) {
                              setState(() {
                                selectedSpoilerOption = value;
                              });
                            },
                          ),
                          const Text("Yes", style: TextStyle(color: white)),
                          const SizedBox(width: 16),
                          Radio<String>(
                            value: "No",
                            groupValue: selectedSpoilerOption,
                            activeColor: primaryRed,
                            onChanged: (value) {
                              setState(() {
                                selectedSpoilerOption = value;
                              });
                            },
                          ),
                          const Text("No", style: TextStyle(color: white)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryRed,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Reviews()));
                          },
                          child: const Text("Submit", style: TextStyle(color: white, fontSize: 18)),
                        ),
                      ),
                      const SizedBox(height: 20), // Ensure extra space at the bottom
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
