import 'package:flutter/material.dart';

class ManagementAreaArabic extends StatelessWidget {
  const ManagementAreaArabic({
    super.key,
    required String title,
    required String username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة المناطق")),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'تحت الإنشاء  - إدارة المناطق',
          style: TextStyle(
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
          
        ),
      ),
    );
  }
}
