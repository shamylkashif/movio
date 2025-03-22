import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movio/utils/app-colors.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String selectedType = 'All';
  int selectedRating = 0;
  String selectedYear = '';
  List<String> selectedGenres = [];

  final List<String> types = ['All', 'Movie', 'TV Series'];
  final List<String> years = ['2025', '2024', '2023', '2022'];
  final List<String> genres = [
    'Western', 'Drama', 'Adventure', 'War', 'Historical', 'Romance', 'Sci-Fi', 'Action',
    'Romantic Comedy', 'Mystery', 'Documentary', 'Comedy', 'Family', 'Melodrama', 'Crime',
    'Musical', 'Cartoon', 'Reality TV', 'Anime'
  ];

  void searchMovies() {

    print('Search movies with:');
    print('Type: $selectedType');
    print('Rating: $selectedRating');
    print('Year: $selectedYear');
    print('Genres: $selectedGenres');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text('Search', style: TextStyle(color: white),),
        titleSpacing: 24,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 45, // Adjust height
                    width: 250,
                    child: TextField(
                      cursorColor: white, // Set cursor color
                      style: TextStyle(color: white),
                      decoration: InputDecoration(
                        hintText: 'Keyword search',
                        hintStyle: TextStyle(color: white),
                        prefixIcon: Icon(Icons.search, color: white),
                        filled: true,
                        fillColor: Colors.black,
                        border: OutlineInputBorder( // Custom border
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: white), // Border color
                        ),
                        enabledBorder: OutlineInputBorder( // Border when not focused
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: white),
                        ),
                        focusedBorder: OutlineInputBorder( // Border when focused
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: white), // Highlighted border color
                        ),
                      ),
                    ),
                  ),
        
                  InkWell(
                      onTap: (){
                        setState(() {
                          selectedType = 'All';
                          selectedRating = 0;
                          selectedYear = '';
                          selectedGenres.clear();
                        });
                      },
                      child: Text('Cancel', style: TextStyle(color: lightGray,fontSize: 17),)),
                ],
              ),
              SizedBox(height: 20),
              Text('Type', style: TextStyle(color: white, fontSize: 20)),
              Wrap(
                spacing: 8,
                children: types.map((type) => ChoiceChip(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  label: Text(type),
                  selected: selectedType == type,
                  onSelected: (selected) {
                    setState(() { selectedType = type; });
                  },
                )).toList(),
              ),
              SizedBox(height: 20),
              Text('Rating', style: TextStyle(color: white, fontSize: 20),),
              RatingBar.builder(
                  itemPadding: EdgeInsets.symmetric(horizontal:10),
                  itemSize: 40,
                  updateOnDrag: true,
                  unratedColor: white,
                  itemBuilder: (context, _)=> Icon(Icons.star, color: Colors.amber,),
                  onRatingUpdate: (rating){
                    setState(() {
                      selectedRating = rating.toInt();
                    });
                  }
              ),

              SizedBox(height: 20),
              Text('Year', style: TextStyle(color: white, fontSize: 20)),
              Wrap(
                spacing: 8,
                children: years.map((year) => ChoiceChip(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  label: Text(year),
                  selected: selectedYear == year,
                  onSelected: (selected) {
                    setState(() { selectedYear = year; });
                  },
                )).toList(),
              ),
              SizedBox(height: 20),
              Text('Genre', style: TextStyle(color: white, fontSize: 20)),
              Wrap(
                spacing: 8,
                children: genres.map((genre) => ChoiceChip(
                  padding: EdgeInsets.symmetric(horizontal: 9, vertical: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  label: Text(genre),
                  selected: selectedGenres.contains(genre),
                  onSelected: (selected) {
                    setState(() {
                      selected ? selectedGenres.add(genre) : selectedGenres.remove(genre);
                    });
                  },
                )).toList(),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: searchMovies,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),
                  child: Text('Search', style: TextStyle(fontSize: 18, color: white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
