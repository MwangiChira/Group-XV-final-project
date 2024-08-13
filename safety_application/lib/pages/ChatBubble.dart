import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // Corrected from 'EdgeInsetcs' to 'EdgeInsets'
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue,
      ), // BoxDecoration
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ), // Text
    ); // Container
  }
}
