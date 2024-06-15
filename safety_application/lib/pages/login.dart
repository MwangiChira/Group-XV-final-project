
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safety_application/firebase_auth.dart';
import 'package:safety_application/main.dart';
import 'package:safety_application/pages/Home_page.dart';
import 'package:safety_application/pages/components/my_button.dart';
import 'package:safety_application/pages/components/my_text_field.dart';

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
  get onTap => null;
  
  get color => null;

  

  void navigateToPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          text: '', 
          onTap: widget.onTap ?? () {}, title: '',
        ),
      ),
    );
  }

//text controllers
 final _formKey = GlobalKey<FormState>();
  final FirebaseAuthServices auth = FirebaseAuthServices();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

   @override
  void dispose() {
    // Avoids memory leak
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 161, 161),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
             key: _formKey,
            child: Column(
              
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  
                  height: 200,
                  width: 400,
                  margin: const EdgeInsets.only(left: 0.0),
                  constraints: const BoxConstraints(minWidth: 100,
    minHeight: 100,
   ),
  padding: const EdgeInsets.only(right: 10.0),
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 246, 247, 248),
  borderRadius: BorderRadius.circular(20),
  
  

  

),

  
),

                //logo
                const SizedBox(height: 50),
                //welcoming message
                const Text(
                  "welcome to safety matters",
                  style: TextStyle(
                    color: Color.fromARGB(255, 13, 15, 13),
                    fontSize: 45,
                    fontFamily: AutofillHints.addressCityAndState,
                  ),
                ),
                //user log in
                const SizedBox(height: 50),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //USER LOG IN
                MyTextField(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  hintText: 'User name',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                //MyButton(onTap: () {}, text: 'sign in'),
                const SizedBox(height: 10),
                 // ignore: unnecessary_new
                 new ElevatedButton(
                    onPressed: signin,
                    child: const MyButton(text: "Sign in"),
                  ),
                Row(
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.onTap,
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
                Row(
                  children: [
                    const SizedBox(width: 10),
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
                  ],
                ),
               
                const Column(
                  children: [
                    SizedBox(height: 10,width: 10,
                      child: Text('Back',style: TextStyle(color: Colors.brown,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

//FIRST TIME USER REGISTRATION
  }
    void signin() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      // ignore: avoid_print
      print('User signed in');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/home");
    } else {
      // ignore: avoid_print
      print('User is not signed in');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, "/registration_page");

    }
  }
}
