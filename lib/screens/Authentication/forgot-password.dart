import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movio/screens/Authentication/password-verification.dart';
import 'package:movio/screens/Authentication/signup-screen.dart';

import '../../utils/app-colors.dart';
import '../../widgets/gradient-icon.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_circle_left_outlined,color: white,)),
        title: Text('Forgot Password', style: TextStyle(color: white),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text('Enter Email Address registered with this platform',style: TextStyle(color: white), ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    hintText: 'abc@gmail.com',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.circular(28)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.circular(28)
                    )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Basic email validation
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 18,),
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text('Back to Log In', style: TextStyle(color: white),)),
            SizedBox(height: 35,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PasswordVerification()));
              },
              child: Container(
                height: 55,
                width: 310,
                decoration: BoxDecoration(
                    color: primaryRed,
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(28), left: Radius.circular(28))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text('Send',
                    style: TextStyle(color: white,fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 70,),
            Text('or', style: TextStyle(fontSize: 18, color: white),),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 143),
              child: Row(
                children: [
                  GradientIcon(
                    icon: FontAwesomeIcons.google,
                    size: 30,
                    gradient: LinearGradient(
                      colors: [Colors.red, Colors.yellow, Colors.blue, Colors.greenAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  SizedBox(width: 25),
                  Icon(FontAwesomeIcons.facebook, color: Colors.blue, size: 30,),
                ],
              ),
            ),


            SizedBox(height: 80,),
            Text('Don\'t have an Account?', style: TextStyle(color: white),),
            SizedBox(height: 15,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryRed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
              },
              child: Text('Sign Up',
                  style: TextStyle(color: white, fontSize: 18)),
            ),


          ],
        ),
      ),
    );
  }
}

