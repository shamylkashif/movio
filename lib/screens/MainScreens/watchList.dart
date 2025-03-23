import 'package:flutter/material.dart';
import 'package:movio/utils/app-colors.dart';
import 'package:movio/widgets/movie-card.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}


class _WatchlistState extends State<Watchlist> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Map<String, dynamic>> watched = [
    {
      'title' : 'Interstellar',
      'poster' : 'assets/TheOrder.jpg',
      'rating' : 7.5,
      'year' : '2023',
      'duration' : '2h 6m'
    },
    {
      'title' : 'Inception',
      'poster' : 'assets/CivilWar.jpeg',
      'rating' : 7.4,
      'year' : '2023',
      'duration' : '2h 6m'
    }
  ];

  final List<Map<String, dynamic>> watchList = [
    {
      'title' : 'Oppenheimer',
      'poster' : 'assets/juror.jpg',
      'rating' : 7.5,
      'year' : '2023',
      'duration' : '2h 6m'
    },
    {
      'title' : 'Inception',
      'poster' : 'assets/CivilWar.jpeg',
      'rating' : 7.4,
      'year' : '2023',
      'duration' : '2h 6m'
    }
  ];

  void initState(){
    super.initState();
    setState(() {
      tabController = TabController(length: 2, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        children: [
          SizedBox(height: 30,),
          TabBar(
              dividerColor: Colors.transparent,
              controller: tabController,
              indicatorColor: white, // Color of the indicator line
              indicatorWeight: 0.6, // Weight of the indicator line
              labelColor: white,
              labelStyle: TextStyle(fontSize: 17),// Color of the selected tab text
              unselectedLabelColor:white, //
              tabs: [
                Tab(text: 'Watched',),
                Tab(text: 'WatchList',)
              ]),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: BouncingScrollPhysics(),
              children: [
               MoviesList(watched),
               MoviesList(watchList),
              ],
            ),
          ),
        ],
      )
    );
  }
}

Widget MoviesList(List<Map<String, dynamic>> movies)
 {
  return ListView.builder(
  itemCount: movies.length,
  itemBuilder:(context, index){
    return MovieCard(
        imageUrl: movies[index]["poster"],
        title: movies[index]["title"],
        rating: movies[index]["rating"],
        year: movies[index]['year'],
        duration: movies[index]['duration'],
        showAddIcon: false,
    );
  },
  );
}
