import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safety_application/firebase_auth.dart';
import 'package:safety_application/firebase_options.dart';
import 'package:safety_application/pages/ChatPage.dart';
import 'package:safety_application/pages/Home_page.dart';
import 'package:safety_application/pages/TherapistPage.dart';
import 'package:safety_application/pages/login_page.dart';
import 'package:safety_application/pages/registration_page.dart';
import 'package:safety_application/pages/user_page.dart';
import 'package:safety_application/services/auth/home_or_getStarted.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
  ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: const MyApp(),
  );
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SignInScreen(
              providers: [],
            );
          }
          return const HomeOrGetstarted();
        });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/Home_page',
        routes: {
          '/': (context) => const LoginPage(),
          '/Home_page': (context) => HomePage(
                text: '',
                onTap: () {},
                title: '',
              ),
          '/registration_page': (context) => RegistrationPage(
                onTap: () {},
              ),
          '/user_page': (context) => const UserPage(),
          '/TherapistPage': (context) => const TherapistPage(),
          '/ChatPage': (context) => const ChatPage(receiverTherapistEmail: '', receiverTherapistId: '',),
        });
  }
}
