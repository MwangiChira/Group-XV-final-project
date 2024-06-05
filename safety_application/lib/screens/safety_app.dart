// user interface
import 'package:flutter/material.dart';

class SafetyApp extends StatefulWidget {
  @override
  _SafetyAppState createState() => _SafetyAppState();
}

class _SafetyAppState extends State<SafetyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safety App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome to the Safety App!'),
            SizedBox(height: 16.0),
            // Add your UI elements here, such as buttons, forms, and so on.
          ],
        ),
      ),
    );
  }
}
