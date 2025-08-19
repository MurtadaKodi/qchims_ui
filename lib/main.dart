import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_02/sites/freaha/freaha.dart';
import 'package:flutter_application_02/sites/location.dart';
import 'package:flutter_application_02/sites/zubara/zubara.dart';
import 'package:flutter_application_02/widget/main/main_section.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: ScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      darkTheme: ThemeData.dark(),
      // Register all routes
      routes: {
        '/zubara': (context) => AlZubara(title: ''),
        '/freaha': (context) => Freaha(title: ''),
        '/location': (context) => LocationMap(title: ''),

      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainSection(title: '',),
    );
  }
}
