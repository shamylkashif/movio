import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movio/screens/MainScreens/home-screen.dart';
import 'package:movio/utils/app-colors.dart';
import 'package:movio/widgets/text-form-fields.dart';
import 'dart:math';

import 'package:movio/widgets/validators.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  String? selectedGender; // Dropdown for Gender
  final _formKey = GlobalKey<FormState>();

  String generateUsername(String fullName) {
    String baseUsername = fullName.toLowerCase().replaceAll(" ", "");
    int randomNum = Random().nextInt(9999);
    return "$baseUsername$randomNum";
  }

  void validateAndSignUp() async {
    if (_formKey.currentState!.validate()) {
      try{
        // Create user in firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        // Get UID od newly created user

        String uid = userCredential.user!.uid;

        // Save additional information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          "fullName" : nameController.text,
          "email" : emailController.text,
          "phoneNumber" : phoneController.text,
          "password" : passwordController.text,
          "gender" : selectedGender,
          "createdAT" : DateTime.now(),
        });
        print("User Registered Successfully!");

        // Navigate to MainScreen

        Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));

      }catch(e){
        // Show firebase error messages
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(e.toString()),
              backgroundColor: primaryRed,)
        );
      }

    } else {
      // Show error message if form validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please fix errors before submitting"),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Sign Up',
                    style: TextStyle(
                        color: white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                CustomTextField(
                    validator: validateName,
                    hintText: "Full Name",
                    controller: nameController,
                    prefixIcon: Icons.person),
                SizedBox(height: 15),
                CustomTextField(
                    validator: validateEmail,
                    hintText: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email),
                SizedBox(height: 15),
                CustomTextField(
                    validator: validatePhone,
                    hintText: "Phone Number",
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone),
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  hint:
                      Text("Select Gender", style: TextStyle(color: white)),
                  items: ["Male", "Female", "Other"]
                      .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(
                            gender,
                          )))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: white.withOpacity(0.5),
                  ),
                  dropdownColor: white,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  validator: validatePassword,
                  hintText: "Password",
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                  suffixIcon: isPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                  isPassword: isPasswordHidden,
                  onSuffixTap: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
                SizedBox(height: 15),
                CustomTextField(
                  validator: (value) => validateConfirmPassword(
                      value, passwordController.text),
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  prefixIcon: Icons.lock,
                  suffixIcon: isConfirmPasswordHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                  isPassword: isConfirmPasswordHidden,
                  onSuffixTap: () {
                    setState(() {
                      isConfirmPasswordHidden = !isConfirmPasswordHidden;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRed,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: validateAndSignUp,
                  child: Text('Sign Up',
                      style: TextStyle(color: white, fontSize: 18)),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Already have an account? Log In",
                      style: TextStyle(color: white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
