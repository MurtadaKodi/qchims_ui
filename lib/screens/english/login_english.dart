import 'package:flutter/material.dart';
import 'package:heritage_ui/screens/english/welcome_page_english.dart';
import 'package:heritage_ui/screens/shared/app_language.dart';
import 'package:heritage_ui/screens/shared/shared_login_page.dart';

void main() {
  runApp(const LogIn(title: ''));
}

class LogIn extends StatelessWidget {
  const LogIn({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInEnglish(title: 'Login Page'),
    );
  }
}

class LogInEnglish extends StatelessWidget {
  const LogInEnglish({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return const SharedLoginPage(language: AppLanguage.english);
  }
}

class LogInOut extends StatelessWidget {
  final String username;
  const LogInOut({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return const WelcomePageEnglish();
  }
}
