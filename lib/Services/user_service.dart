import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Fetch User Data
  Future<MovieAppUser?> getUserData() async {
    try {
      if (currentUserId == null) {
        print("No logged-in user.");
        return null;
      }

      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(currentUserId).get();

      if (userDoc.exists) {
        return MovieAppUser.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        print("User not found in Firestore.");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  // Check if user exists
  Future<bool> checkUserExists(String uid) async {
    try {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(uid).get();
      return userDoc.exists;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

  // Update User Profile
  Future<bool> updateUserProfile(MovieAppUser updatedUser) async {
    try {
      if (currentUserId == null) return false;

      DocumentReference userRef =
      _firestore.collection('users').doc(currentUserId);

      DocumentSnapshot userDoc = await userRef.get();
      if (!userDoc.exists) {
        print("User does not exist in Firestore.");
        return false;
      }

      await userRef.update(updatedUser.toJson());
      return true;
    } catch (e) {
      print("Error updating user profile: $e");
      return false;
    }
  }

  // Delete User Account (from Firestore and Firebase Auth)
  Future<bool> deleteUserAccount() async {
    try {
      if (currentUserId == null) return false;

      // Delete from Firestore
      await _firestore.collection('users').doc(currentUserId).delete();

      // Delete from Firebase Auth
      await _auth.currentUser?.delete();

      // Sign out user
      await _auth.signOut();

      return true;
    } catch (e) {
      print("Error deleting user account: $e");
      return false;
    }
  }
}
