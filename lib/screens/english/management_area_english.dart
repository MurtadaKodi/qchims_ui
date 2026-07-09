import 'package:flutter/material.dart';
import 'package:heritage_ui/screens/shared/app_strings.dart';

class ManagementAreaEnglish extends StatelessWidget {
  const ManagementAreaEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    const text = AppStrings.english;

    return Scaffold(
      appBar: AppBar(title: Text(text.managementArea)),
      body: Center(child: Text(text.managementAreaComingSoon, style: TextStyle(fontSize: 24))),
    );
  }
}
