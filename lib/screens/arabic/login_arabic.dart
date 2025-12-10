import 'package:flutter/material.dart';
import 'package:heritage_ui/land_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heritage_ui/screens/arabic/welcom_page_arabic.dart';

void main() {
  runApp(const LogIn(title: '', lastLang: '',));
}

class LogIn extends StatelessWidget {
  const LogIn({super.key, required String title, required String lastLang});

  Future<String?> getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('savedUser');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getSavedUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LogInArabic(title: 'Login Page', lastLang: ''));
        }

        final savedUser = snapshot.data;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Login App',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            useMaterial3: true,
          ),
          home: savedUser != null
              ? LogInOut(username: savedUser)
              : const LogInArabic(title: 'Login Page', lastLang: ''),
        );
      },
    );
  }
}

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.indigo,
//       body: Center(
//         child: CircularProgressIndicator(color: Colors.white),
//       ),
//     );
//   }
// }

class LogInArabic extends StatefulWidget {
  const LogInArabic({super.key, required String title, required String lastLang});

  @override
  State<LogInArabic> createState() => _LogInArabicState();
}

class _LogInArabicState extends State<LogInArabic> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // قائمة المستخدمين داخل الكود
  final Map<String, String> _users = {
    "murtada": "12345",
    "user": "12345",
    "ferhan": "12345",
    "jawaher": "11111",
    "faisal": "99999",
    "noora": "88888",
    "khalid": "qwerty",
    "mohamed": "pass123",
    "layla": "flutter",
    "yousef": "2025",
  };

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (_users.containsKey(username) && _users[username] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('savedUser', username);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LogInOut(username: username)),
        );
      }
    } else {
      setState(() {
        _errorMessage = "Invalid username or password ❌";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" صفحة تسجيل الدخول"),
        backgroundColor: Colors.indigo,
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_outline,
                        size: 70, color: Colors.indigo),
                    const SizedBox(height: 10),
                    const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "اسم المستخدم",
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "كلمة المرور",
                        prefixIcon: Icon(Icons.lock_outline),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _login,
                          icon: const Icon(Icons.login),
                          label: const Text(
                            " إبدأ  ",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LanguageSelectorPage(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.language),
                          label: const Text(
                            "Change Language / تغيير اللغة",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
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

class LogInOut extends StatelessWidget {
  final String username;
  const LogInOut({super.key, required this.username});


  @override
  Widget build(BuildContext context) {
    return WelcomPage();
  }
}
