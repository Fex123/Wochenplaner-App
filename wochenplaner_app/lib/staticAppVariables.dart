import 'package:flutter/material.dart';
import 'package:wochenplaner_app/theme.dart';

class AppColors {
  static const ExtendedColor late =
      MaterialTheme.late; // Unchecked and late color
  static const ExtendedColor inProgress =
      MaterialTheme.inProgress; // In Progress color
  static const Color notStarted =
      Color.fromARGB(255, 107, 107, 107); // Not started color
  static const Color onNotStarted = Color.fromARGB(255, 255, 255, 255);
  static const Color done = Color(0xFF008D32); // Done color
  static const Color onDone = Color.fromARGB(255, 255, 255, 255);
}

class StaticComponents {
  static staticAppBar(String title) {
    return AppBar(
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
          )),
      automaticallyImplyLeading: false,
    );
  }
}
