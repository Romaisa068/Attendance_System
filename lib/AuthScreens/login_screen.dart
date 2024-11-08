import 'package:attend_system/AuthScreens/signup_screen.dart';
import 'package:attend_system/FirebaseAuth/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attend_system/UserPanel/user_screen.dart';
import 'package:attend_system/components.dart';
import 'package:attend_system/constant.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String id = 'Login_Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  final FirebaseServices _auth = FirebaseServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  void signIn() async {
    String email = _email.text;
    String password = _password.text;

    try {
      User? user = await _auth.signInwithEmailPassword(email, password);

      if (user != null) {
        Navigator.pushNamed(context, UserScreen.id);
      } else {
        //print('SignIn failed');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-in failed. Please check your details.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("SignIn Failed: $e ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.lightBlue,
              child: Icon(
                Icons.person,
                size: 80.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Login",
                style: KtextStyle,
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            ReuseableTextWidget(
              text: "Enter your email",
              textInputType: TextInputType.emailAddress,
              controller: _email,
            ),
            const SizedBox(
              height: 12.0,
            ),
            ReuseableTextWidget(
              text: "******",
              textInputType: TextInputType.visiblePassword,
              controller: _password,
              obsecureText: true,
            ),
            const SizedBox(
              height: 18.0,
            ),
            ReuseableButton(
                text: 'Login',
                onPressed: signIn,
                backgroundColor: Colors.lightBlue),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignupScreen.id);
              },
              child: Text.rich(
                TextSpan(
                    text: "Don't have an account ? ",
                    style: KButtonTextStyle.copyWith(
                        fontSize: 12, color: Colors.white38),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: KButtonTextStyle.copyWith(
                          fontSize: 14,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
