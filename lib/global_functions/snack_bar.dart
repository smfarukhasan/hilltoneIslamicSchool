import 'package:flutter/material.dart';

//how to use: showGlobalSnackBar(context,'Alhamdulillah');
//SnackBar

void showGlobalSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center, // টেক্সট সেন্টার করার জন্য
        ),
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
    ),
  );
}