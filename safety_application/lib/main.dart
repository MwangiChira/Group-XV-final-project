import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safety_application/services/auth/home_or_getStarted.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    print("Environment variables loaded successfully.");
  } catch (e) {
    print("Error loading .env file: $e");
  }

  FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
  );

  try {
    await Firebase.initializeApp(
      options: firebaseOptions,
    );
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(MyApp());
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Safety App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainScreen(),
//       // body: Center(
//    //     child: PanicButton(),
//    //   ),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;

//   // static List<Widget> _widgetOptions = <Widget>[
//   //   HomeScreen(),
//   //   ReportCrimeScreen(),
//   //   MentalHealthScreen(),
//   //   TherapistBookingScreen(),
//   //   SettingsScreen(),
//   // ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // body: Center(
//       //   // child: _widgetOptions.elementAt(_selectedIndex),
//       // ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.report),
//             label: 'Report',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.health_and_safety),
//             label: 'Mental Health',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.book_online),
//             label: 'Therapists',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

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