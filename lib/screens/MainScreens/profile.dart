import 'package:flutter/material.dart';
import 'package:movio/SubScreens/settings.dart';
import 'package:movio/utils/app-colors.dart';
import '../../widgets/movie-card.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                              const Text(
                                "kate",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
                                },
                                icon: const Icon(Icons.settings, color: white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              ProfileStat(title: "Watched", count: 12),
                              SizedBox(width: 20),
                              ProfileStat(title: "Review", count: 22),
                              SizedBox(width: 20),
                              ProfileStat(title: "WatchList", count: 22),
                            ],
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
                MoviesList(),
                MoviesList(),
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
  const MoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: const [
        MovieCard(
          imageUrl: "assets/TheOrder.jpg",
          title: "RED ONE",
          year: "2024",
          duration: "2h 3m 12A",
          rating: 6.4,
          showAddIcon: false,
        ),
      ],
    );
  }
}