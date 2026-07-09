// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heritage_ui/screens/shared/app_language.dart';
import 'package:heritage_ui/screens/shared/shared_welcome_page.dart';

void main() {
  runApp(const WelcomeArabic());
}

class WelcomeArabic extends StatelessWidget {
  const WelcomeArabic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.cairoTextTheme(), primaryColor: Colors.lightBlue),
      home: const WelcomePageArabic(),
    );
  }
}

class WelcomePageArabic extends StatelessWidget {
  const WelcomePageArabic({super.key});

  @override
  Widget build(BuildContext context) {
    return const SharedWelcomePage(language: AppLanguage.arabic);
  }
}
