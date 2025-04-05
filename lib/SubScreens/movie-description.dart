import 'package:flutter/material.dart';
import 'package:movio/SubScreens/reviews.dart';
import 'package:movio/utils/app-colors.dart';
import 'package:provider/provider.dart';
import '../Provider/movies_provider.dart';
import '../Services/tmdb_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {

  Map<String, int> genres = {};

  String _limitTitle(String title){
    List<String> words = title.split(" ");
    return words.length > 3 ? "${words.take(3).join(" ")}..." : title ;
  }

  String formatDuration(int? minutes) {
    if (minutes == null || minutes <= 0) return "N/A";
    int hours = minutes ~/ 60;
    int mins = minutes % 60;
    return hours > 0 ? "$hours h ${mins} min" : "$mins min";
  }

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  // Fetch movie details and genres
  Future<void> _fetchMovieDetails() async {
    try {
      // Call fetchGenres, which returns a map of genre names to IDs
      final genresMap = await TMDbService.fetchGenres();  // No need to pass movie ID

      setState(() {
        // Set the genres to the map returned by fetchGenres
        genres = genresMap;  // genres will be a Map<String, int>
      });
    } catch (e) {
      print("Error fetching movie details: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    bool isWatched = moviesProvider.isWatched(widget.movie);
    bool isWatchList = moviesProvider.isInWatchlist(widget.movie);
    bool isFavorite = moviesProvider.isFavorite(widget.movie);

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: white,size: 20,),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                     widget.movie['title'] ?? "N/A" ,
                      style: TextStyle(fontSize: 20, color: white),
                      overflow: TextOverflow.ellipsis,
                    ),
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
            Stack(
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${widget.movie["backdrop_path"] ??widget.movie["poster_path"]}",
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    onTap: (){
                      moviesProvider.toggleFavorite(context, widget.movie);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5), // Semi-transparent black
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: isFavorite ? Colors.red : white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(_limitTitle(widget.movie['title'] ?? "N/A") , overflow: TextOverflow.ellipsis ,style: TextStyle(color: white,fontSize: 24),)),
                      Text(widget.movie['release_date'].split('-')[0] ?? "N/A",style: TextStyle(color: white),),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: yellow, size: 18),
                          SizedBox(width: 4),
                          Text(widget.movie['vote_average'].toString() , style: TextStyle(color: white),),
                        ],
                      ),
                      Text(formatDuration(widget.movie["duration"] ?? 0), style: TextStyle(color: white),),
                    ],
                  ),
                  const SizedBox(height: 12),

                  genres.isEmpty
                  ? SizedBox(
                    height: 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: genres.keys.map<Widget>((genreName) {
                        return GenreChip(label: genreName);  // Access 'name' from the genre map
                      }).toList(),
                    ),
                  )
                  : Text("No genres available", style: TextStyle(color: white)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isWatched ? white : Colors.black,
                            side: BorderSide(color: white),
                          ),
                          onPressed: (){
                            moviesProvider.toggleWatched(context, widget.movie);
                          },
                          child: Text('Watched',
                            style:TextStyle(color: isWatched ? Colors.black : white) ,),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isWatchList ? white : Colors.black,
                            side: BorderSide(color: white),
                          ),
                          onPressed: () {
                            moviesProvider.toggleWatchlist(context, widget.movie);
                          },
                          child: Text('Add To Watchlist',
                          style: TextStyle(color: isWatchList ? Colors.black : white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                   Text(
                    widget.movie['overview'],
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
