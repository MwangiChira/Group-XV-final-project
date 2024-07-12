import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<AuthenticatedUser?> signUpAsUser(
      String email, String password, String userType) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      // Store user data in Firestore
      await firestore.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'userType': userType,
      });

      return AuthenticatedUser(user: user, role: userType);
    } catch (e) {
      // ignore: avoid_print
      print('Sign up error: $e');
      return null;
    }
  }

  Future<AuthenticatedUser?> signUpAsTherapist(
  String email, String password, String name, String specialization) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Generate unique TID
      // ignore: prefer_const_constructors
      var uuid = Uuid();
      String tid = uuid.v4();

      // Store therapist data in Firestore in both 'users' and 'therapists' collections
      await firestore.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'userType': 'therapist',
        'tid': tid,
      });

      await firestore.collection('therapists').doc(tid).set({
        'tid': tid,
        'uid': user.uid,
        'email': email,
        'name': name,
        'specialization': specialization,
      });

      return AuthenticatedUser(user: user, role: 'therapist', tid: tid);
    } catch (e) {
      // ignore: avoid_print
      print('Sign up error: $e');
      return null;
    }
  }

  Future<AuthenticatedUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      // Check if the user is a therapist
      DocumentSnapshot doc =
          await firestore.collection('therapists').doc(user!.uid).get();
      if (doc.exists) {
        String tid = doc.get('tid');
        return AuthenticatedUser(user: user, role: 'therapist', tid: tid);
      }

      // If not a therapist, assume user
      return AuthenticatedUser(user: user, role: 'user');
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

class AuthenticatedUser {
  final User? user;
  final String role;
  final String? tid;

  AuthenticatedUser({required this.user, required this.role, this.tid});
}

class UserProvider with ChangeNotifier {
  AuthenticatedUser? _authenticatedUser;

  AuthenticatedUser? get authenticatedUser => _authenticatedUser;

  void setAuthenticatedUser(AuthenticatedUser user) {
    _authenticatedUser = user;
    notifyListeners();
  }

  void clearUser() {
    _authenticatedUser = null;
    notifyListeners();
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: 'incorrect_password');
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
