import 'package:flutter/material.dart';

class CircularOutline {
  static OutlineInputBorder circularOutline({
    double borderRadius = 30.0,
    Color borderColor = Colors.grey,
    double borderWidth = 1.0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    );
  }
}