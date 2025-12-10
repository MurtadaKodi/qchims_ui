import 'package:flutter/material.dart';
import 'package:heritage_ui/screens/arabic/login_arabic.dart';
import 'package:heritage_ui/screens/english/login_english.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل اللغة الأخيرة قبل تشغيل التطبيق
  final prefs = await SharedPreferences.getInstance();
  final lastLang = prefs.getString('lastLanguage') ?? '';

  runApp(LandPage(lastLang: lastLang));
}

class LandPage extends StatelessWidget {
  final String lastLang;

  const LandPage({super.key, required this.lastLang});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Selector',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      // إذا سبق واختار لغة، افتحها مباشرة
      home: lastLang == 'arabic'
          ? LogInArabic(title: '', lastLang: lastLang)
          : lastLang == 'english'
          ? EnglishPage()
          : LanguageSelectorPage(),
    );
  }
}

class LanguageSelectorPage extends StatelessWidget {
  const LanguageSelectorPage({super.key});

  Future<void> _saveLanguage(BuildContext context, String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastLanguage', lang);

    if (lang == 'english') {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => LogInEnglish(title: 'Login Page')),
      );
    } else {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (_) => LogInArabic(title: '', lastLang: lang),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Language /  اللغة', style: TextStyle(fontSize: 20, color: Colors.white),),
        centerTitle: true,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(image: DecorationImage(
          image: NetworkImage('https://res.cloudinary.com/dmklduciw/image/upload/v1716195150/DJI_0262_ieuxeo.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please select your language:\nيرجى اختيار لغتك المفضلة:',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // زر العربية
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    // icon: Icon(Icons.flag, color: Colors.white),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        '🇶🇦    العربية',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _saveLanguage(context, 'arabic'),
                  ),
                ),
                SizedBox(height: 20),
                // زر الإنجليزية
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    // icon: Icon(Icons.language, color: Colors.white),
                    label: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        '🇺🇸  English',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _saveLanguage(context, 'english'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EnglishPage extends StatelessWidget {
  const EnglishPage({super.key});

  Future<void> _resetLanguage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastLanguage');
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (_) => LanguageSelectorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(title: Text('Heritage UI Main Page')),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://res.cloudinary.com/dmklduciw/image/upload/v1686040911/WebSite%20Images/Forts/Bidda-1_dqasfo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language, size: 80, color: Colors.white),
              SizedBox(height: 16),
              Text(
                'Welcome! to Heritage UI \n مرحباً! إلى واجهة المستخدم التراثية ',
                style: TextStyle(color: Colors.white, fontSize: 22),
        
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.language, size: 24, color: Colors.blueAccent),
                label: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Choose Language \n اختر اللغة',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                onPressed: () => _resetLanguage(context),
              ),
            ],
            
          ),
        ),
      ),
    );
  }
}

