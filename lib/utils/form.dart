import 'package:flutter/material.dart';

InputDecoration getLabelDecoration(String label) {
  return InputDecoration(
    focusColor: Colors.black,
    labelStyle: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    labelText: label,
  );
}
