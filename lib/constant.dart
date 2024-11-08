// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const KButtonTextStyle =
    TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);

const KColorize = [Colors.white, Colors.purple, Colors.yellow, Colors.red];

const KtextStyle = TextStyle(
  color: Colors.white,
  fontSize: 36.0,
  fontWeight: FontWeight.bold,
);

const KTextFielddecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(25.0),
    ),
  ),
  hintStyle: TextStyle(color: Colors.white30),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32.0),
    ),
  ),
);
