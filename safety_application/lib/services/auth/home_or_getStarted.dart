// ignore: file_names
import 'package:flutter/material.dart';
import 'package:safety_application/pages/Home_page.dart';
import 'package:safety_application/services/auth/login_or_register.dart';

class HomeOrGetstarted extends StatefulWidget {


  const HomeOrGetstarted({super.key});

  @override
  State<HomeOrGetstarted> createState() => _HomeOrGetstartedState();
}

class _HomeOrGetstartedState extends State<HomeOrGetstarted> {
  bool showHomePage = true;

  void togglepages() {
    setState(() {
      showHomePage = !showHomePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showHomePage) {
      return HomePage(
        onTap: togglepages,
        text: '', title: '',
      );
    } else {
      return const LoginOrRegister();
    }
  }
}
