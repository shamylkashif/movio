import 'package:flutter/material.dart';
import 'package:movio/SubScreens/write-review.dart';
import 'package:movio/utils/app-colors.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body:Center(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WriteReview()));
          },
          child: Text('Write your review',
            style: TextStyle(color: white, fontSize: 30),),
        ),
      ),
    );
  }
}
