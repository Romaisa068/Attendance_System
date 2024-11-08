import 'package:attend_system/constant.dart';
import 'package:flutter/material.dart';

class ReuseableTextWidget extends StatelessWidget {
  const ReuseableTextWidget(
      {super.key,
      required this.text,
      required this.textInputType,
      required this.controller,
      this.obsecureText = false});

  final String text;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: textInputType,
        obscureText: obsecureText,
        style: KButtonTextStyle.copyWith(
            fontSize: 16.0, fontWeight: FontWeight.w500),
        decoration: KTextFielddecoration.copyWith(hintText: text));
  }
}

class ReuseableButton extends StatelessWidget {
  const ReuseableButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.backgroundColor});

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            backgroundColor: backgroundColor,
            minimumSize: const Size(100.0, 50.0)),
        child: Text(
          text,
          style: KButtonTextStyle,
        ),
      ),
    );
  }
}
