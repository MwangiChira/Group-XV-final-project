import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.text, required this.onTap, required this.title });

  final String text;
  final void Function() onTap;
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 161, 161),
      drawerScrimColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Center(
              child: Text(
                'SALAMA MIND',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  fontFamily: AutofillHints.organizationName,
                ),
              ),
            ),
            const SizedBox(height: 100),
             Image.asset(
              'assets/images/Nira.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 200),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/'); // Replace with actual route
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 62, 119, 167),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

