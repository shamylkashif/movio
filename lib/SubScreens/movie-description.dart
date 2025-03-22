import 'package:flutter/material.dart';
import 'package:movio/SubScreens/reviews.dart';
import 'package:movio/utils/app-colors.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isWatchedSelected = false;
  bool isWatchlistSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30,),
              child: Row(
                children: [
                  Positioned(
                    top: 40,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, color: white,size: 20,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Text(
                    'Red One',
                    style: TextStyle(fontSize: 20, color: white),
                  ),
                  SizedBox(width: 150,),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Reviews()));
                      },
                      child: Text('Review', style: TextStyle(color: white, fontSize: 20),)),
                ],
              ),
            ),
            Image.asset(
              'assets/juror.jpg', // Replace with movie poster URL
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Red One', style: TextStyle(color: white,fontSize: 24),),
                      Text('2024',style: TextStyle(color: white),),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: yellow, size: 18),
                          SizedBox(width: 4),
                          Text('6.7', style: TextStyle(color: white),),
                        ],
                      ),
                      Text('2h 12m', style: TextStyle(color: white),),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        GenreChip(label: 'Mystery'),
                        GenreChip(label: 'Action'),
                        GenreChip(label: 'Adventure'),
                        GenreChip(label: 'Comedy'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isWatchedSelected ? white : Colors.black,
                            side: BorderSide(color: white),
                          ),
                          onPressed: (){
                            isWatchedSelected = !isWatchedSelected;
                            isWatchlistSelected = false;
                          },
                          child: Text('Watched',
                            style:TextStyle(color: isWatchedSelected ? Colors.black : white) ,),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isWatchlistSelected ? white : Colors.black,
                            side: BorderSide(color: white),
                          ),
                          onPressed: () {
                            isWatchlistSelected = !isWatchlistSelected;
                            isWatchedSelected = false;
                          },
                          child: Text('Add To Watchlist',
                          style: TextStyle(color: isWatchlistSelected ? Colors.black : white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'After Santa Claus is kidnapped, the North Pole\'s Head of Security must team up with a notorious hacker in a globe-trotting, action-packed mission to save Christmas.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: white,),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class GenreChip extends StatelessWidget {
  final String label;
  const GenreChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(label, style: TextStyle(fontSize: 12, color: white)),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: white, width: 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      ),
    );
  }
}
