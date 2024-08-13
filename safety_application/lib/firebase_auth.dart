import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password, String userType) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // ignore: avoid_print
      print('Sign up error: $e');
    return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
     // ignore: avoid_print
     print('Sign up error: $e');
    return null;
    }
  }

  signUpAsTherapist(String email, String password, String name, String specialization) {}

  signUpAsUser(String email, String password, String userType) {}
}
