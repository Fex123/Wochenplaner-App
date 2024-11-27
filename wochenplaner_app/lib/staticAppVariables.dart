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
  static const Color done =
      Color(0xFF00BDE8); // Color.fromRGBO(0, 141, 50, 1); // Done color
  static const Color onDone = Color.fromARGB(255, 255, 255, 255);
}

class StaticComponents {
  static staticAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              //fontFamily: 'monosquare'
              color: Theme.of(context).colorScheme.onPrimaryFixed)),
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
    );
  }
}
