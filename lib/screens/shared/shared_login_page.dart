import 'package:flutter/material.dart';
import 'package:heritage_ui/land_page.dart';
import 'package:heritage_ui/screens/shared/app_language.dart';
import 'package:heritage_ui/screens/shared/app_strings.dart';
import 'package:heritage_ui/screens/shared/shared_welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLoginPage extends StatefulWidget {
  const SharedLoginPage({super.key, required this.language});

  final AppLanguage language;

  @override
  State<SharedLoginPage> createState() => _SharedLoginPageState();
}

class _SharedLoginPageState extends State<SharedLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  static const Map<String, String> _users = {
    'murtada': '12345',
    'user': '12345',
    'ferhan': '12345',
    'jawaher': '11111',
    'faisal': '99999',
    'noora': '88888',
    'khalid': 'qwerty',
    'mohamed': 'pass123',
    'layla': 'flutter',
    'yousef': '2025',
  };

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastLanguage', language.code);
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (_users.containsKey(username) && _users[username] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedUser', username);
      await _saveLanguage(widget.language);

      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SharedWelcomePage(language: widget.language)),
      );
      return;
    }

    setState(() {
      _errorMessage = AppStrings.of(widget.language).loginError;
    });
  }

  Future<void> _toggleLanguage() async {
    final target = widget.language.isArabic ? AppLanguage.english : AppLanguage.arabic;
    await _saveLanguage(target);

    if (!mounted) {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SharedLoginPage(language: target)),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = AppStrings.of(widget.language);

    return Scaffold(
      appBar: AppBar(
        title: Text(text.loginPageTitle),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            tooltip: text.toggleToOtherLanguage,
            onPressed: _toggleLanguage,
            icon: const Icon(Icons.toggle_on),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3949AB), Color(0xFF7986CB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline, size: 70, color: Colors.indigo),
                    const SizedBox(height: 10),
                    Text(
                      text.loginTitle,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: text.usernameLabel,
                        prefixIcon: const Icon(Icons.person_outline),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: text.passwordLabel,
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        _buildActionButton(
                          onPressed: _login,
                          icon: Icons.login,
                          label: text.loginButton,
                        ),
                        const SizedBox(height: 10),
                        _buildActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LanguageSelectorPage()),
                            );
                          },
                          icon: Icons.language,
                          label: text.manualLanguageButton,
                        ),
                      ],
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 10),
                      Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
