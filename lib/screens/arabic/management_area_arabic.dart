import 'package:flutter/material.dart';
import 'package:heritage_ui/screens/shared/app_strings.dart';

class ManagementAreaArabic extends StatelessWidget {
  const ManagementAreaArabic({super.key, required String title, required String username});

  @override
  Widget build(BuildContext context) {
    const text = AppStrings.arabic;

    return Scaffold(
      appBar: AppBar(title: Text(text.managementArea)),
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          text.managementAreaComingSoon,
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
