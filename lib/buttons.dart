// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyButtons());

class MyButtons extends StatelessWidget {
  const MyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Four External Buttons',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ButtonPage(),
    );
  }
}

class ButtonPage extends StatelessWidget {
  // Example URIs
  static final Uri _google = Uri.parse('https://www.google.com');
  static final Uri _wikipedia = Uri.parse('https://www.wikipedia.org');
  static final Uri _flutter = Uri.parse('https://flutter.dev');
  static final Uri _youtube = Uri.parse('https://www.youtube.com');

  const ButtonPage({super.key});

  Future<void> _openUri(BuildContext context, Uri uri) async {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // If it fails, show a SnackBar with an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open ${uri.toString()}')),
      );
    }
  }

  Widget _buildButton(BuildContext context, {required IconData icon, required String label, required Uri uri}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 56)),
        icon: Icon(icon),
        label: Text(label, style: TextStyle(fontSize: 16)),
        onPressed: () => _openUri(context, uri),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open External Pages')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildButton(context, icon: Icons.search, label: 'Open Google', uri: _google),
            _buildButton(context, icon: Icons.book, label: 'Open Wikipedia', uri: _wikipedia),
            _buildButton(context, icon: Icons.flutter_dash, label: 'Open Flutter', uri: _flutter),
            _buildButton(context, icon: Icons.video_library, label: 'Open YouTube', uri: _youtube),
          ],
        ),
      ),
    );
  }
}

