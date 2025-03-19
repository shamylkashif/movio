
import 'package:flutter/material.dart';
import 'package:movio/screens/Authentication/new-password.dart';

import '../../utils/app-colors.dart';


class PasswordVerification extends StatefulWidget {

  const PasswordVerification({super.key, });

  @override
  State<PasswordVerification> createState() => _PasswordVerificationState();
}

class _PasswordVerificationState extends State<PasswordVerification> {

  final List<TextEditingController> otpControllers =
  List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_circle_left_outlined, color: white,),
        ),
        title: Text('Verification', style: TextStyle(color: white),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Text('Enter verification code', style: TextStyle(fontSize: 16,color: white),),
            SizedBox(height: 30),
            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: TextFormField(
                    controller: otpControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: white),
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 25),
            RichText(
              text: TextSpan(
                text: "If you didn't receive a code, ",
                style: TextStyle(color: white),
                children: [
                  TextSpan(
                    text: "Resend",
                    style: TextStyle(color: primaryRed),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPassword()));
              },
              child: Container(
                height: 55,
                width: 320,
                decoration: BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(28),
                    left: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Verify',
                    style: TextStyle(color: white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
