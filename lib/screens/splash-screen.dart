import 'package:flutter/material.dart';
import 'package:movio/screens/Authentication/login-screen.dart';
import 'package:movio/utils/app-colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    moveToNextScreen(context: context);
  }

  Future<void> moveToNextScreen({required BuildContext context}) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: background,
      body: Center(
          child: Text('Movio', style: TextStyle(color: primaryRed, fontSize: 35,
                 fontWeight:FontWeight.w800  ),)) ,
    );
  }
}
