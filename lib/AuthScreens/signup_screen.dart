import 'package:attend_system/AuthScreens/login_screen.dart';
import 'package:attend_system/FirebaseAuth/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attend_system/components.dart';
import 'package:attend_system/constant.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const String id = 'Signup_Screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseServices _auth = FirebaseServices();

  bool isLoading = false;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  void signUp() async {
    String username = _name.text;
    String email = _email.text;
    String password = _password.text;

    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));

      User? user =
          await _auth.signUpwithEmailPassword(email, password, username);
      if (user != null) {
        Navigator.pushNamed(context, LoginScreen.id);
      }
    } catch (e) {
      print('Sign up failed');
    } finally {
      setState(() {
        isLoading = false;
      });
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create an Account",
                style: KtextStyle.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            ReuseableTextWidget(
                text: 'Name',
                textInputType: TextInputType.text,
                controller: _name),
            const SizedBox(
              height: 12.0,
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
            Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ReuseableButton(
                      text: 'Sign Up',
                      onPressed: signUp,
                      backgroundColor: Colors.lightBlue),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Text.rich(
                TextSpan(
                    text: "Already have an account ? ",
                    style: KButtonTextStyle.copyWith(
                        fontSize: 12, color: Colors.white38),
                    children: [
                      TextSpan(
                        text: 'Login',
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
