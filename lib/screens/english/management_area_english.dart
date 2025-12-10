import 'package:flutter/material.dart';

class ManagementAreaEnglish extends StatelessWidget {
  const ManagementAreaEnglish({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Management Area'),
      ),
      body: const Center(
        child: Text('Management Area Coming Soon...', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}