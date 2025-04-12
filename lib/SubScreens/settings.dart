import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movio/Services/auth_services.dart';
import 'package:movio/SubScreens/about.dart';
import 'package:movio/SubScreens/complain.dart';
import 'package:movio/SubScreens/delete-acc.dart';
import 'package:movio/screens/Authentication/login-screen.dart';

import '../utils/app-colors.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool isNotification = false;
  bool isLoading = false;
  final AuthService _authService = AuthService();
  String? userName;

  @override
  void initState() {
    super.initState();
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
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new, color: white,)),
      ),
      body: Center(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            SizedBox(height: 15,),
            Text(
              userName ?? 'Loading...',
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

            SizedBox(height: 30,),

            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                onPressed:() async {
                  setState(() {
                    isLoading = true;
                  });
                  await _authService.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                },
                child: isLoading
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text(
                  'Log out',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),),
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

