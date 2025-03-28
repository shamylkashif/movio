import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up with Email & Password
  Future<String?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
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
