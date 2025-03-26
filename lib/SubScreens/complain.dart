import 'package:flutter/material.dart';

import '../utils/app-colors.dart';


class Complain extends StatefulWidget {
  const Complain({super.key});

  @override
  State<Complain> createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new, color: white),
      ),
    ),
      body: Column(

      ),
    );
  }
}
