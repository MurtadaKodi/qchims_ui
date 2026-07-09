// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heritage_ui/screens/shared/app_language.dart';
import 'package:heritage_ui/screens/shared/shared_welcome_page.dart';

void main() {
  runApp(const WelcomeEnglish());
}

class WelcomeEnglish extends StatelessWidget {
  const WelcomeEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.cairoTextTheme(), primaryColor: Colors.lightBlue),
      home: const WelcomePageEnglish(),
    );
  }
}

class WelcomePageEnglish extends StatelessWidget {
  const WelcomePageEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedWelcomePage(language: AppLanguage.english);
  }
}
