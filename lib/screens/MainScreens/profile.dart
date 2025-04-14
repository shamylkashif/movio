
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movio/SubScreens/settings.dart';
import 'package:movio/utils/app-colors.dart';
import 'package:provider/provider.dart';
import '../../Provider/movies_provider.dart';
import '../../widgets/movie-card.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {


  late TabController _tabController;

  String? userName;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchUserName();
  }

  // Method to fetch the user's name from Firestore
  Future<void> _fetchUserName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users') // Collection where user data is stored
            .doc(user.uid) // Document ID is the user's UID
            .get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'] ?? 'User';  // Assuming the user's name field is 'name'
          });
        }
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: const Text("Profile", style: TextStyle(color: white,)),
        titleSpacing: -20,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: background,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userName ?? 'Loading...',
                                style: const TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountSettings()));
                                },
                                icon: const Icon(Icons.settings, color: white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Consumer<MoviesProvider>
                                (builder: (context, provider, child) {
                                  return ProfileStat(title: "Watched", count: provider.watchedCount);
                              }),
                              SizedBox(width: 20),
                              Consumer<MoviesProvider>
                                (builder: (context, provider, child) {
                                return ProfileStat(title: "Fav", count: provider.favoriteCount);
                              }),                               SizedBox(width: 20),
                              Consumer<MoviesProvider>
                                (builder: (context, provider, child) {
                                return ProfileStat(title: "WatchList", count: provider.watchlistCount);
                              }),                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 35),
          TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicatorColor: white,
            indicatorWeight: 2.0,
            labelColor: white,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Watched"),
              Tab(text: "Favorite"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                MoviesList(type: "watched"),
                MoviesList(type: "favorite")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileStat extends StatelessWidget {
  final String title;
  final int count;
  const ProfileStat({Key? key, required this.title, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$count",
          style: const TextStyle(
            color: lightGray,
            fontSize: 18,
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: white, fontSize: 14),
        ),
      ],
    );
  }
}



class MoviesList extends StatelessWidget {
  final String type;
  const MoviesList({super.key, required this.type});

  String formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    return "${hours}h ${mins}m";
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    List<Map<String, dynamic>> movies =
    (type == "watched") ? moviesProvider.watchedMovies : moviesProvider.favoriteMovies;
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




Future<void> saveMovieToFirestore({
  required String userId,
  required String userName,
  required String movieId,
  required String title,
  required String releaseDate,
  required double voteAverage,
  required int duration,
}) async {
  try {
    // Log the data being saved
    print("Saving movie to Firestore for user: $userId");

    // Get the current timestamp for when the movie was saved
    Timestamp savedAt = Timestamp.now();

    // Add movie data to Firestore under the user's 'favorites' collection
    await FirebaseFirestore.instance
        .collection('favorites')  // Main collection for favorites
        .doc(userId)  // User's document ID (userId)
        .collection('movies')  // Subcollection where each movie is saved separately
        .add({
      'userName': userName,  // Save userName from users collection
      'userId': userId,      // Save userId
      'movieId': movieId,
      'title': title,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'duration': duration,
      'savedAt': savedAt,
    });

    print("Movie saved successfully!");
  } catch (e) {
    print("Error saving movie: $e");
  }
}




