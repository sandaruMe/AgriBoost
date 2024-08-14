import 'package:flutter/material.dart';

import 'colors.dart';

const TextStyle descriptionStyle = TextStyle(
  fontSize: 15,
  color: textLight,
  fontWeight: FontWeight.w400,
);

const textInputDecoration = InputDecoration(

  hintStyle: TextStyle(color: Colors.teal, fontSize: 15),
  fillColor: lgreen,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  // set text color to white
  labelStyle: TextStyle(color: Colors.teal),

);


const textInputDecoration_dropdown = InputDecoration(

  hintStyle: TextStyle(color: Colors.teal, fontSize: 15),
  fillColor: lgreen,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: mainYellow, width: 1),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  ),
  // set text color to white
  labelStyle: TextStyle(color: Colors.teal),

);