import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration:  InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide( color:Colors.white),
        ),
        fillColor: const Color.fromARGB(255, 233, 229, 216),
        filled: true,
        hintText: hintText,
        hintStyle:const TextStyle(color: Color.fromARGB(255, 122, 118, 118)),
        
      ),
      
    );
    

  }
  
}
