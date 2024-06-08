import 'package:flutter/material.dart';
import 'package:safety_application/pages/Home_page.dart';
import 'package:safety_application/services/auth/login_or_register.dart';


class BackToHome extends StatefulWidget {
  final VoidCallback onTap;
  const BackToHome({super.key, required this.onTap});

  @override
  State<BackToHome> createState() => _BackToHomeState();
}

class _BackToHomeState extends State<BackToHome> {
  bool showHomePage = true;
  void toggleback() {
    setState(() {
      showHomePage = !showHomePage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showHomePage) {
      return HomePage(
        onTap: toggleback,
        text: '',
      );
    } else {
      return LoginOrRegister(onTap: toggleback);
    }
   
  }
}