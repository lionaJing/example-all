import 'package:flutter/material.dart';

TextStyle getCustomFontTextStyle() {
  return const TextStyle(
    color: Colors.blueAccent,
    // set the font family as defined in pubspec.yaml
    fontFamily: 'Pacifico',
    // set the font weight
    fontWeight: FontWeight.w400,
    // set the font size
    fontSize: 36.0,
  );
}
