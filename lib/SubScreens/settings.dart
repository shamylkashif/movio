import 'package:flutter/material.dart';
import 'package:movio/SubScreens/about.dart';
import 'package:movio/SubScreens/complain.dart';
import 'package:movio/SubScreens/delete-acc.dart';

import '../utils/app-colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new, color: white,)),
      ),
      body: Center(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(height: 15,),
            Text(
              "kate",
              style: TextStyle(
                color: white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
        SizedBox(height: 30,),
        Listile(
          title: 'Turn on movie notification',
          icon: isNotification ? Icons.radio_button_on : Icons.radio_button_off,
          onTap: () {
            setState(() {
              isNotification = !isNotification;
            });
          },
        ),

         Listile(
             title: 'Delete account',
             icon: Icons.keyboard_double_arrow_right_sharp,
             onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DeleteAccount()));
             }),
         Listile(
             title: 'Complain',
             icon: Icons.keyboard_double_arrow_right_sharp,
             onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Complain()));
             }),
         Listile(
             title: 'About',
             icon: Icons.keyboard_double_arrow_right_sharp,
             onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
             }),



          ],
        ),
      ),
    );
  }
}

class Listile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const Listile({super.key, required this.title, required this.icon, required this.onTap, });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
        style: TextStyle(color: white, fontSize: 17),),
      trailing: IconButton(onPressed: onTap, icon: Icon(icon, color: white,)),
    );
  }
}

