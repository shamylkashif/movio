import 'package:flutter/material.dart';

import '../../utils/app-colors.dart';
import 'login-screen.dart';


class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool _isObscured = true;
  bool _isConfirmObscured = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        title: Text('New Password', style: TextStyle(color: white),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: Text('Enter new password', style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: _passwordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility,),color: darkGray,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  hintText: 'At least 8 digits',
                  hintStyle: TextStyle(color:lightGray),
                  fillColor: white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.circular(28)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.circular(28)
                  )
              ),
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text('Confirm Paaword', style: TextStyle(color: white),),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: _isConfirmObscured,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _isConfirmObscured = !_isConfirmObscured;
                        });
                      },
                      icon: Icon(_isConfirmObscured ? Icons.visibility_off : Icons.visibility,),color: darkGray,),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: lightGray),
                  filled: true,
                  fillColor: white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.circular(28)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: white),
                      borderRadius: BorderRadius.circular(28)
                  )
              ),
            ),
          ),
          SizedBox(height: 50,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
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
                child: Text('Confirm',
                  style: TextStyle(color: white,fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
