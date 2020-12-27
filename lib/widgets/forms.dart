import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget boldTextStyle(text, {fontSize = 15.0}) {
  return new Text('$text',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
      ));
}

Widget bolderTextStyle(text, {fontSize = 15.0}) {
  return new Text('$text',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ));
}

Color appColor() {
  return Colors.blueGrey[800];
}

Color appSecondaryColor() {
  return Colors.teal;
}
