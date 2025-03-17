import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movio/screens/Authentication/forgot-password.dart';
import 'package:movio/screens/home-screen.dart';
import 'package:movio/screens/Authentication/signup-screen.dart';
import 'package:movio/utils/app-colors.dart';
import 'package:movio/widgets/signin-button.dart';
import 'package:movio/widgets/text-form-fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    // Ensure the status bar is visible
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Align(
              alignment: Alignment.center,
              child: Text('Log In',
                style: TextStyle(color: white, fontSize: 22,fontWeight: FontWeight.bold ),),
            ),
            SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.only(right: 280),
              child: Text('Email',
              style: TextStyle(color: white, fontSize: 18 ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                    hintText: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(right: 245),
              child: Text('Password',
                style: TextStyle(color: white, fontSize: 18 ),
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  hintText: "Password",
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                  suffixIcon: isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                  isPassword: isPasswordHidden,
                  onSuffixTap: (){
                    setState(() {
                      isPasswordHidden =! isPasswordHidden;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));},
                child:Text('Log In', style: TextStyle(color: white,fontSize: 18),)
            ),
            SizedBox(height: 10,),

            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                },
                child: Text('Forgot Password', style: TextStyle(color: white, fontSize: 13.5),)
            ),

            SizedBox(height: 5,),

            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: white, fontSize: 14.5),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                      color: primaryRed, // Make it look like a link
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                    }
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text('Or', style: TextStyle(color: white, fontSize: 18),),

            SizedBox(height: 30,),

            Column(
              children: [
                CustomSignInButton(
                    text: "Sign In with Google ",
                    icon: FontAwesomeIcons.google,
                    iconColor: primaryRed,
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    } ),
                SizedBox(height: 15,),

                CustomSignInButton(
                    text: "Sign In with Microsoft ",
                    icon: FontAwesomeIcons.microsoft,
                    iconColor: primaryRed,
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    } ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
