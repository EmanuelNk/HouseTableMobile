import 'package:flutter/material.dart';

Widget propText(String data, double size, Color textColor){
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
    child: Text(data,
      style: TextStyle (
          color: textColor,
          fontSize: size
      ),
    ),
  );
}