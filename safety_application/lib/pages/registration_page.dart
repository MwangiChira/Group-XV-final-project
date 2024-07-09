import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safety_application/firebase_auth.dart';
import 'package:safety_application/main.dart';
import 'package:safety_application/pages/components/my_text_field.dart';

void main() {
  runApp(const MyApp());
}

class RegistrationPage extends StatefulWidget {
  final VoidCallback onTap;
  const RegistrationPage({super.key, required this.onTap});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // text controllers
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthServices auth = FirebaseAuthServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String successMessage = '';
  String _userType = 'normal';

  get therapist => null; // default user type

  @override
  void dispose() {
    // avoids memory leak
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // sign-up method
  void signUp() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      String name = nameController.text;
      String specialization = '';

      User? user = (await auth.signUpAsUser(email, password, _userType)) as User?;
      User? therapist =
          (await auth.signUpAsTherapist(email, password, name, specialization)) as User?;
      if (user != null) {
        setState(() {
          successMessage = 'You have successfully signed up!';
        });
        if (mounted) {
          Navigator.pushNamed(context, "/home");
        } else if (therapist != null) {
          setState(() {
            successMessage = 'You have successfully signed up!';
              Navigator.pushNamed(context, "/user_page");
          });
        }
      } else {
        setState(() {
          successMessage = 'Signup failed. Please try again.';
        });
      }
    }
  }

  // method to check if email is registered
  Future<void> checkEmail(String email) async {
    try {
      // Try signing in with the provided email and an incorrect password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: 'incorrect_password');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          successMessage = 'Email is not registered.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          successMessage = 'Email is already registered.';
        });
      } else {
        setState(() {
          successMessage = 'Error: ${e.message}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 161, 161),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    height: 200,
                    width: 400,
                    margin: const EdgeInsets.only(left: 0.0),
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      minHeight: 100,
                    ),
                    padding: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 246, 247, 248),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // welcoming message
                  const Text(
                    "Let's create an account for you!",
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 14, 13),
                      fontSize: 45,
                    ),
                  ),
                  const SizedBox(height: 50),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: nameController,
                    hintText: 'User Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _userType,
                    items: const [
                      DropdownMenuItem(
                          value: 'normal', child: Text('Normal User')),
                      DropdownMenuItem(
                          value: 'therapist', child: Text('Therapist')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _userType = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: signUp,
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    successMessage,
                    style: TextStyle(
                      color: successMessage.contains('successfully')
                          ? const Color.fromARGB(255, 28, 34, 28)
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
