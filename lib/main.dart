import 'package:attend_system/AuthScreens/login_screen.dart';
import 'package:attend_system/AuthScreens/signup_screen.dart';
import 'package:attend_system/UserPanel/user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        SignupScreen.id: (context) => const SignupScreen(),
        UserScreen.id: (context) => const UserScreen(),
      },
    );
  }
}
