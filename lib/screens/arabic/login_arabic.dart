import 'package:flutter/material.dart';
import 'package:heritage_ui/screens/arabic/welcome_page_arabic.dart';
import 'package:heritage_ui/screens/shared/app_language.dart';
import 'package:heritage_ui/screens/shared/shared_login_page.dart';

void main() {
  runApp(const LogIn(title: '', lastLang: ''));
}

class LogIn extends StatelessWidget {
  const LogIn({super.key, required String title, required String lastLang});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInArabic(title: 'Login Page', lastLang: ''),
    );
  }
}

class LogInArabic extends StatelessWidget {
  const LogInArabic({super.key, required String title, required String lastLang});

  @override
  Widget build(BuildContext context) {
    return const SharedLoginPage(language: AppLanguage.arabic);
  }
}

class LogInOut extends StatelessWidget {
  final String username;
  const LogInOut({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return const WelcomePageArabic();
  }
}
