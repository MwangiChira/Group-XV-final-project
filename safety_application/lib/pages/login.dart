import 'package:flutter/material.dart';
import 'package:safety_application/main.dart';
import 'package:safety_application/pages/Home_page.dart';
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
  void navigateToPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          text: '',
          onTap: widget.onTap ?? () {},
        ),
      ),
    );
  }

//text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.safety_check,
                  size: 100,
                  color: Color.fromARGB(255, 16, 204, 32),
                ),
                //logo
                const SizedBox(height: 50),
                //welcoming message
                const Text(
                  "welcome to safety matters",
                  style: TextStyle(
                    color: Color.fromARGB(255, 16, 204, 32),
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
                Row(
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Color.fromARGB(255, 11, 230, 66),
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
                          color: Color.fromARGB(255, 11, 230, 66),
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
                    SizedBox(
                      height: 10,
                      width: 10,
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.brown,
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
}
