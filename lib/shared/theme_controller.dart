import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = Rx<ThemeMode>(ThemeMode.light);

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    update();
  }
  void setDarkMode() {
    themeMode.value = ThemeMode.dark;
    update(); // Update the ThemeMode within the Rx object
    // To customize colors, use ThemeData in your MaterialApp's theme property.
  }

  void setLightMode() {
    themeMode.value = ThemeMode.light;
    update();

     // Update the ThemeMode within the Rx object
  }

  void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

// ThemeMode is an enum and cannot be extended with copyWith.
// To customize theme colors, use ThemeData in your MaterialApp.