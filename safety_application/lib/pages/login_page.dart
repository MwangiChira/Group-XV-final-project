import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safety_application/firebase_auth.dart';
import 'package:safety_application/main.dart';
import 'package:safety_application/pages/components/my_text_field.dart';
import 'package:safety_application/pages/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class LoginPage extends StatefulWidget {
  final VoidCallback? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuthServices auth = FirebaseAuthServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String successMessage = '';
  String _userType = 'normal';

  get onTap => null;

  @override
  void dispose() {
    // Avoids memory leak
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

//WE create a fuction for navigating throught the pages
  void navigateToPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(
          onTap: widget.onTap ?? () {},
        ),
      ),
    );
  }

//we create a funtion to sign in the user and compair their iemails with the ones in the database using firebase Authentication
  void signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    // ignore: unnecessary_cast
    AuthenticatedUser? user = (await auth.signInWithEmailAndPassword(email, password)) as AuthenticatedUser?;

    if (user != null) {
      setState(() {
        successMessage = 'Successfully signed in';
        Navigator.pushNamed(context, "/user_page");
      });
    } else {
      setState(() {
        successMessage = 'Sign in failed. Please try again.';
         Navigator.pushNamed(context, "/registration_page");
      });
    }
  }

  // This function checks whether the email is registered in the database
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
                      image: const DecorationImage(image: AssetImage('assets/images/image3')),
                      color: const Color.fromARGB(255, 246, 247, 248),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Welcoming message
                  const Text(
                    "Welcome to Safety Matters",
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 15, 13),
                      fontSize: 45,
                      fontFamily: AutofillHints.addressCityAndState,
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
                  DropdownButtonFormField<String>(
              value: _userType,
              items: const [
                DropdownMenuItem(value: 'normal', child: Text('Normal User')),
                DropdownMenuItem(value: 'therapist', child: Text('Therapist')),
              ],
              onChanged: (value) {
                setState(() {
                  _userType = value!;
                });
              },
                  ),
                  
                   ElevatedButton(
                      // We include the sign-in method defined below and then call the checkEmail function defined in the FirebaseAuthServices
                      onPressed: signIn,
                      onLongPress: () =>
                          checkEmail(emailController.text.trim()),
                      child: const Text('Sign In'),
                    ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?'),
                  
                      GestureDetector(
                        onTap: () => navigateToPage(context),
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Color.fromARGB(255, 6, 8, 7),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: AutofillHints.addressCityAndState,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => navigateToPage(context),
                    child: const Text(
                      'Back to HOME PAGE',
                      style: TextStyle(
                        color: Color.fromARGB(255, 9, 10, 9),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: AutofillHints.addressCityAndState,
                      ),
                    ),
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

class AuthenticatedUser {
}
