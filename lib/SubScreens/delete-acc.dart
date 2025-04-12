import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/Authentication/login-screen.dart';
import '../utils/app-colors.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  // Method to delete the account from Firebase and Firestore
  Future<void> deleteAccount() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // Ask for re-authentication if needed
        if (user.metadata.lastSignInTime?.isBefore(DateTime.now().subtract(Duration(days: 1))) ?? false) {
          // Re-authenticate the user if their session is expired
          await _reauthenticateUser(user);
        }

        // Deleting user data from the 'users' collection in Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Now delete the user's account from Firebase Authentication
        await user.delete();

        // Sign the user out after deletion
        await _auth.signOut();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your account has been deleted successfully.')),
        );

        // Navigate to the login screen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      // Handle specific errors (e.g., re-authentication required)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Method to re-authenticate the user
  Future<void> _reauthenticateUser(User user) async {
    // You need to ask the user for their credentials. For this example, we assume the user has a password.
    // You can create a dialog to ask the user for their email and password.

    // Assuming the user is logged in with email/password, you can use:
    TextEditingController passwordController = TextEditingController();
    final _key = GlobalKey<FormState>();

    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Re-authenticate'),
          content: Form(
            key: _key,
            child: TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_key.currentState?.validate() ?? false) {
                  // Attempt to reauthenticate
                  try {
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user.email!,
                      password: passwordController.text,
                    );

                    await user.reauthenticateWithCredential(credential);
                    Navigator.of(context).pop(true);  // Continue deletion
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Re-authentication failed: $e')),
                    );
                    Navigator.of(context).pop(false);  // Stop deletion
                  }
                }
              },
              child: Text('Authenticate'),
            ),
          ],
        );
      },
    );

    if (result != true) {
      throw FirebaseAuthException(code: 'requires-recent-login', message: 'Reauthentication required');
    }
  }

  // Method to confirm account deletion
  Future<void> confirmDeleteAccount() async {
    bool? confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text(
            'Do you really want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      deleteAccount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          'Delete Account',
          style: TextStyle(color: white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'After deleting your account:',
              style: TextStyle(fontSize: 20, color: white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              'Your account will be deleted permanently, '
                  'along with all associated personal data.',
              style: TextStyle(fontSize: 16, color: white),
              maxLines: 4,
            ),
          ),
          SizedBox(height: 30),
          Center(
            child: InkWell(
              onTap: isLoading ? null : confirmDeleteAccount,
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
