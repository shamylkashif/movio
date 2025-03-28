import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movio/screens/Authentication/forgot-password.dart';
import 'package:movio/screens/MainScreens/home-screen.dart';
import 'package:movio/screens/Authentication/signup-screen.dart';
import 'package:movio/utils/app-colors.dart';
import 'package:movio/widgets/signin-button.dart';
import 'package:movio/widgets/text-form-fields.dart';
import 'package:movio/widgets/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordHidden = true;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Ensure the status bar is visible
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Log In',
                  style: TextStyle(
                      color: white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 280),
                child: Text(
                  'Email',
                  style: TextStyle(color: white, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  hintText: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  validator: validateEmail,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 245),
                child: Text(
                  'Password',
                  style: TextStyle(color: white, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  hintText: "Password",
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                  suffixIcon: isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                  isPassword: isPasswordHidden,
                  validator: validatePassword,
                  onSuffixTap: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      // If login is successful, navigate to MainScreen
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => MainScreen()));
                    } on FirebaseAuthException catch (e) {
                      String errorMessage = "An error occurred. Please try again.";
                      // Show the error message in an alert dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Login Failed"),
                            content: Text(errorMessage),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: white, fontSize: 18),
                  )),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: white, fontSize: 13.5),
                  )),
              SizedBox(
                height: 5,
              ),
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
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          }),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Or',
                style: TextStyle(color: white, fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  CustomSignInButton(
                      text: "Sign In with Google ",
                      icon: FontAwesomeIcons.google,
                      iconColor: primaryRed,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSignInButton(
                      text: "Sign In with Facebook ",
                      icon: FontAwesomeIcons.facebook,
                      iconColor: Colors.blue,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
