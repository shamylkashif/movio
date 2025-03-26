import 'package:flutter/material.dart';

import '../utils/app-colors.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text('Delete Account', style: TextStyle(color: white,),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new, color: white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'After deleting your account:',
              style: TextStyle(fontSize: 20, color: white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text('Your account will be deleted right away permanentaly, '
                'along with all associated personal data.',
              style: TextStyle(fontSize: 16, color: white),
              maxLines: 4,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: InkWell(
              onTap: (){},
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                    'Delete Account',
                    style: TextStyle(color: white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
