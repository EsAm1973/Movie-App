import 'package:flutter/material.dart';

class NNavigationBarTheme {
  static NavigationBarThemeData lightNavigationBar = NavigationBarThemeData(
    backgroundColor: Colors.grey.shade200,
    elevation: 0,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    indicatorColor: Color.fromARGB(255, 204, 20, 7),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) => const TextStyle(
        color: Colors.black54,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) => const IconThemeData(color: Colors.grey),
    ),
    
  );

  static NavigationBarThemeData darkNavigationBar = NavigationBarThemeData(
    backgroundColor: Colors.grey.shade900,
    elevation: 0,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    indicatorColor: Color.fromARGB(255, 204, 20, 7),
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) =>  TextStyle(
        color: Colors.grey.shade200,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) => const IconThemeData(color: Colors.white),
    ),
  );
}
