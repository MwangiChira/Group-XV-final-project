import 'package:flutter/material.dart';
import 'package:safety_application/services/auth/home_or_getStarted.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeOrGetstarted(),
    );
  }
}