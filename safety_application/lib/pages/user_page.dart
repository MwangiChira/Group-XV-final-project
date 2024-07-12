import 'package:flutter/material.dart';
import 'package:safety_application/pages/components/panic_button.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  get onTap => null;

  get navigateToPage => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/TherapistPage');
              },
              child: const Text('Therapist')),
          const Row(
            children: [
              Text(' Hello user'),
              Image(image: AssetImage('assets/images/nira.png'))
            ],
          ),
          const PanicButton(),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/ChatPage');
              },
              child: const Text('your chat page'))
        ],
      ),
    );
  }
}
