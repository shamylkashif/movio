import 'package:flutter/material.dart';
import 'package:movio/utils/app-colors.dart';
import 'package:movio/widgets/movie-card.dart';
import 'package:provider/provider.dart';

import '../../Provider/movies_provider.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}


class _WatchlistState extends State<Watchlist> with SingleTickerProviderStateMixin {
  late TabController tabController;

  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
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
                 MovieList(type: "watched"),
                 MovieList(type: "watchlist"),
              ],
            ),
          ),
        ],
      )
    );
  }
}



class MovieList extends StatelessWidget {
  final String type;
  const MovieList({super.key, required this.type});

  String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return "${hours}h ${mins}m";
  }



  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    List<Map<String, dynamic>> movies =
    (type == "watched") ? moviesProvider.watchedMovies : moviesProvider.watchlistMovies;
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder:(context, index){
        return MovieCard(
          imageUrl: movies[index]["poster_path"], // Use poster_path from TMDB
          title: movies[index]["title"] ?? "Unknown",
          rating: movies[index]["vote_average"] ?? 0.0,
          year: (movies[index]["release_date"]?.toString().split('-')[0]) ?? 'N/A',
          duration: formatDuration(
              int.tryParse(movies[index]["duration"]?.toString() ?? '0') ?? 0
          ),          showAddIcon: false,
        );
      },
    );
  }
}

