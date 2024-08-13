import 'package:flutter/material.dart';
import 'package:safety_application/pages/login_page.dart';
import 'package:safety_application/pages/registration_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show the login page
  bool showLoginPage = true;

  // Method to toggle between the two pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegistrationPage(onTap: togglePages);
    }
  }
}
