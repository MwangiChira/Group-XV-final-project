import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<User?> signUpAsUser(String email, String password, String userType) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      // Store user data in Firestore
      await firestore.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'userType': 'user', // Assuming you have a user type field
      });

      return user;
    } catch (e) {
      // ignore: avoid_print
      print('Sign up error: $e');
      return null;
    }
  }

  Future<User?> signUpAsTherapist(String email, String password, String name, String specialization) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Store additional therapist data in Firestore
      await firestore.collection('therapists').doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'name': name,
        'specialization': specialization,
      });

      return user;
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
      print('Sign in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}


class CheckEmailPage extends StatefulWidget {
  const CheckEmailPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckEmailPageState createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  final TextEditingController emailController = TextEditingController();
  String message = '';

  Future<void> checkEmail(String email) async {
    try {
      // Try signing in with the provided email and an incorrect password
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: 'incorrect_password');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          message = 'Email is not registered.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          message = 'Email is already registered.';
        });
      } else {
        setState(() {
          message = 'Error: ${e.message}';
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  

  }
