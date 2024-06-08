import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
     
  
      child: SizedBox(width: 150, height: 70, 
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            decoration: BoxDecoration(color: Colors.black, 
            borderRadius: BorderRadius.circular(9)),
            
            //child text
            child: Center(
              child: Text(text,style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),

      
    );
  }
}
