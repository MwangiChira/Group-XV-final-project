import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // ignore: avoid_types_as_parameter_names
  const HomePage({super.key, required this.text, required this.onTap });

  final String text;
  final void Function() onTap;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onTap,
              child: const Center(
                child: Text(
                  'SALAMA MIND',
                  style: TextStyle(
                    color: Colors.brown,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: widget.onTap,
              child: const Text(
                'User',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: widget.onTap,
              child: const Text(
                'Therapist',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
