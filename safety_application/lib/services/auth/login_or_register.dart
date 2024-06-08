import 'package:flutter/material.dart';
import 'package:safety_application/pages/login.dart';
import 'package:safety_application/pages/registration_page.dart';

class LoginOrRegister extends StatefulWidget {
  final VoidCallback? onTap;
  const LoginOrRegister( {super.key, this.onTap});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show the log in page
  bool showLoginPage = true;



  // we create a methpd to toggle between the two pages 

  void togglePages(){
    setState(() {
      showLoginPage =!showLoginPage;
    });

  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage ) {
      return LoginPage(onTap: togglePages);
    }
    else {
      return RegistrationPage(onTap: togglePages);
    }
  }
}
