import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // ignore: avoid_types_as_parameter_names
  const HomePage({super.key, required this.text, required this.onTap, required String title });

  final String text;
  final void Function() onTap;

  @override
  State<HomePage> createState() => _HomePageState();
}



class HompePage extends StatelessWidget {
  const HompePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        
        // Define additional colors here
      ),
      home: HomePage(text: '', onTap: () {  }, title: '',),
    );
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Color.fromARGB(255, 53, 161, 161),
      drawerScrimColor: Colors.green,
      body: Center( 
        child: Column(  
          children: [ 
          
           const Center(
                child: Text(
                  'SALAMA MIND',
                  style: TextStyle(
                    color: Colors.brown,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            
            const SizedBox(height: 20),
TextButton(
  onPressed: () {Navigator.pushNamed(context, '/'); 
  },// Replace '/therapist_page' with your actual route name
  child: const Text(
    'GET STARTED',
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
