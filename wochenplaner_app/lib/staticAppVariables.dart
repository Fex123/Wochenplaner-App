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

class AppLocales {
  static const List<String> supportedLocales = ['de', 'en'];
}

class StaticComponents {
  static staticAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              //fontFamily: 'monosquare'
              color: Theme.of(context).colorScheme.onPrimaryContainer)),
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}

class StaticStyles {
  static appButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        shadowColor: Colors.transparent,
        textStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer));
  }

  static appInputDecoration(BuildContext context, String labelText) {
    const double borderRadius = 20.0;
    return InputDecoration(
      filled: true,
      fillColor: Theme.of(context).colorScheme.primaryContainer,
      // Background color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: Color.fromARGB(0, 33, 149, 243),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: Color.fromARGB(0, 33, 149, 243),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .onPrimaryContainer, // Border color when focused
        ),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Theme.of(context)
            .colorScheme
            .onPrimaryContainer, // Label text color
      ),
    );
  }
}
