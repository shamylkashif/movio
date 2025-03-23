import 'package:flutter/material.dart';
import 'package:movio/SubScreens/movie-description.dart';
import 'package:movio/screens/MainScreens/profile.dart';
import 'package:movio/screens/MainScreens/search.dart';
import 'package:movio/screens/MainScreens/watchList.dart';
import 'package:movio/utils/app-colors.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    Watchlist(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[900],
        selectedItemColor: primaryRed,
        unselectedItemColor: lightGray,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30,), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark, size: 30,), label: "Saved"),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 30,), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _bannerMovies = [
    "assets/after.webp",
    "assets/alone.webp",
    "assets/train.webp",
  ];

  final List<Map<String, dynamic>> _recommendedMovies = [
    {
      "title": "Juror #2",
      "image": "assets/juror.jpg",
      "year": "2024",
      "duration": "1h 54m",
      "rating": 7.0,
    },
    {
      "title": "Civil War",
      "image": "assets/CivilWar.jpeg",
      "year": "2024",
      "duration": "1h 49m",
      "rating": 7.0,
    },
    {
      "title": "The Order",
      "image": "assets/TheOrder.jpg",
      "year": "2024",
      "duration": "1h 49m",
      "rating": 6.3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _bannerMovies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsScreen()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_bannerMovies[index]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recommended", style: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("See all", style: TextStyle(color: primaryRed, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recommendedMovies.length,
              itemBuilder: (context, index) {
                final movie = _recommendedMovies[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetailsScreen()));
                  },
                  child: Container(
                    width: 140,
                    margin: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.asset(movie["image"], fit: BoxFit.cover, height: 140, width: 140),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie["title"], style: TextStyle(color: white, fontWeight: FontWeight.bold)),
                                SizedBox(height: 5),
                                Text("${movie["year"]}  •  ${movie["duration"]}", style: TextStyle(color: lightGray, fontSize: 12)),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: yellow, size: 14),
                                    SizedBox(width: 4),
                                    Text("${movie["rating"]}", style: TextStyle(color: white)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
