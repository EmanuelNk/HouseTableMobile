import 'package:flutter/material.dart';

Widget propText(String data, double size, Color textColor) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
    child: Text(
      data,
      textAlign: TextAlign.center,
      style: TextStyle(color: textColor,  fontSize: size),
    ),
  );
}

Widget titledPropText(
    String title, String data, double size, Color titleColor, Color textColor) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title + ': ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: titleColor, fontSize: size),
          ),
        ),
        Text(
          data,
          style: TextStyle(color: textColor,  fontSize: size),
        ),
      ],
    ),
  );
}
