import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:heritage_ui/land_page.dart';
import 'package:heritage_ui/profile.dart';
import 'package:heritage_ui/screens/arabic/login_arabic.dart';
import 'package:heritage_ui/screens/english/location_map_english.dart';
import 'package:heritage_ui/screens/english/management_area_english.dart';
import 'package:heritage_ui/screens/english/polygon_map_english.dart';
// Make sure that polygon_map.dart defines a PolygonMap widget and is present in the correct path.
import 'package:heritage_ui/shared/theme_controller.dart';
import 'package:heritage_ui/screens/arabic/welcom_page_arabic.dart';
import 'package:heritage_ui/widget/my_themes.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MaterialApp(
        theme: themeController.themeMode.value == ThemeMode.light
            ? ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                textTheme: ThemeData.light(useMaterial3: true).textTheme
                    .copyWith(
                      bodyLarge: TextStyle(
                        color: const Color.fromARGB(255, 8, 31, 137),
                      ),
                      bodyMedium: TextStyle(color: Colors.black),
                      bodySmall: TextStyle(
                        color: const Color.fromARGB(255, 238, 32, 32),
                      ),
                    ),
              )
            : ThemeData.dark(),
        darkTheme: MyThemes.customDarkTheme,
        themeMode: themeController.themeMode.value,
        scrollBehavior: ScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
        ),
        routes: {
          '/locationMapEnglish': (context) =>
              const LocationMapEnglish(title: 'Location Map', username: ''),
          '/floatingPopupPolygonMap': (context) =>
              const FloatingPopupPolygonMap(title: '', username: ''),
          '/welcome': (context) => const WelcomArabic(title: ''),
          '/managementArea': (context) => const ManagementAreaEnglish(),
          '/login': (context) =>
              const LogInArabic(title: '', lastLang: ''), // Add this line
        },
        debugShowCheckedModeBanner: false,
        // home: LogIn(title: 'Quick Info', lastLang: '',),
        // home: FloatingPopupPolygonMap(title: 'Quick Info', username: '',),
        // home: LoginPage(title: 'Quick Info'),
        // home : PolygonMapArabic(title: 'Quick Info', username: '',),
        home: LandPage(lastLang: 'english'),
        // home: const ProfilePage(),
      ),
    );
  }
}
