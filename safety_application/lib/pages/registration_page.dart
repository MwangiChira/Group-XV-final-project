import 'package:flutter/material.dart';
import 'package:safety_application/main.dart';
import 'package:safety_application/pages/components/my_text_field.dart';

void main(){
  runApp(const MyApp());
}

class RegistrationPage  extends StatefulWidget {
  final VoidCallback onTap;
  const RegistrationPage({super.key, required this.onTap});

  
@override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
// ignore: unused_element
class _RegistrationPageState extends State<RegistrationPage> {
//text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordcontroller = TextEditingController();

  //signup methpd 
  void signUp() async{}
  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //logo
              const Icon(
                Icons.safety_check,
                size: 100,
                color: Color.fromARGB(255, 16, 204, 32),
              ),
              const SizedBox(height: 50),
              //welcoming message
              const Text(
                "Let's create an account for you!",
                style: TextStyle(color: Color.fromARGB(255, 16, 204, 32), fontSize: 45, fontFamily: AutofillHints.addressCityAndState),
              ),
              //user log in
const SizedBox(height: 50),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                
              ),

              const SizedBox(height:10),
//USER LOG IN
              MyTextField(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              MyTextField(
                controller: nameController,
                hintText: 'User name',
                obscureText: false,
              ),
     const SizedBox(height: 10),
               MyTextField(
                controller: confirmPasswordcontroller,
                hintText: 'Confirm password',
                obscureText: true,
              ),
     const SizedBox(height: 10),
              //button for signing up

            //MyButton(onTap: () {}, 
              //text: 'Sign up'),
               const SizedBox(height: 10),

      Row(
        children: [
          const Text('already a member?'),
          const SizedBox(width: 10),
         GestureDetector(
          onTap: widget.onTap,
           child: const Text(
            'Login now',
            style: TextStyle(
              color: Color.fromARGB(255, 55, 230, 11),
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: AutofillHints.addressCityAndState,
            ),
           ),
         ),

      ],
      ),
            ]),
          ),
        ),
      ),
      
//FIRST TIME USER REGISTRATION
   
    );
  }
}

