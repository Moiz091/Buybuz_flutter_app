import 'package:flutter/material.dart';

showSnackBar(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.grey,
      content: Text(
        title,
        style: TextStyle(color: Colors.white),
      )));
}
