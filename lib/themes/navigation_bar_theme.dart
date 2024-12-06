import 'package:flutter/material.dart';

class NNavigationBarTheme {
  static NavigationBarThemeData lightNavigationBar = NavigationBarThemeData(
    backgroundColor: Colors.grey.shade200,
    elevation: 0,
    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    indicatorColor: Colors.purpleAccent.shade700,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) => const TextStyle(
        color: Colors.black54,
        fontSize: 12,
        fontWeight: FontWeight.w500,
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
    indicatorColor: Colors.purpleAccent.shade700,
    labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
      (states) =>  TextStyle(
        color: Colors.grey.shade200,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
      (states) => const IconThemeData(color: Colors.white),
    ),
  );
}
