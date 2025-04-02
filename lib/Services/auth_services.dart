import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up with Email & Password and Store in Firestore
  Future<String?> signUp(String email, String password, String name, String phone, String gender) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get UID of the registered user
      String uid = userCredential.user!.uid;

      // Store user details in Firestore
      await _firestore.collection("users").doc(uid).set({
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "gender": gender,
        "profileImage": "", // Empty for now, can be updated later
        'createdAt': FieldValue.serverTimestamp(), // Store signup timestamp
      });

      return null; // No error, sign-up successful
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    } catch (e) {
      return "An unknown error occurred. Please try again.";
    }
  }

  // Sign In with Email & Password
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // No error, sign-in successful
    } on FirebaseAuthException catch (e) {
      return _handleAuthException(e);
    } catch (e) {
      return "An unknown error occurred. Please try again.";
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Handle Firebase Auth Errors
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return "The email format is invalid.";
      case 'email-already-in-use':
        return "This email is already registered.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      default:
        return "Authentication error: ${e.message}";
    }
  }
}
