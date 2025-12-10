// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heritage_ui/main.dart';
import 'package:heritage_ui/screens/english/location_map_english.dart';
import 'package:heritage_ui/screens/english/management_area_english.dart';
import 'package:heritage_ui/screens/english/polygon_map_english.dart';

void main() {
  runApp(const WelcomEnglish(title: ''));
}

class WelcomEnglish extends StatelessWidget {
  const WelcomEnglish({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.cairoTextTheme(),
        primaryColor: Colors.lightBlue,
      ),
      home: WelcoPage(),
    );
  }
}

class WelcoPage extends StatelessWidget {
  const WelcoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          ' Heritage UI',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 32),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MainApp()),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),

          // المحتوى الرئيسي
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // الصورة
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          // ignore: duplicate_ignore
                          // ignore: deprecated_member_use
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        'https://res.cloudinary.com/dmklduciw/image/upload/v1755496893/fort_Profile_xiov9t.png',
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // العبارات الترحيبية
                  Text(
                    "Welcome to Heritage UI",
                    style: GoogleFonts.cairo(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   " Enjoy a sleek and user-friendly experience \n استمتع بتجربة أنيقة وسهلة الاستخدام",
                  //   style: GoogleFonts.cairo(
                  //     fontSize: 16,
                  //     color: Colors.black54,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 30),

                  // أزرار القائمة
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    LocationMapEnglish(title: '', username: ''),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            size: 24,
                          ),
                          label: const Text(
                            "Heritage Map",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FloatingPopupPolygonMap(
                                  title: '',
                                  username: '',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.info_outline, size: 24),
                          label: const Text(
                            "Heritage Info",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManagementAreaEnglish(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.settings, size: 24),
                          label: const Text(
                            "Management Area ",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // التذييل
          Container(
            // color: Colors.blueAccent.withOpacity(0.1),
            padding: const EdgeInsets.all(22.0),
            child: Text(
              "© 2024 Heritage UI. All rights reserved.",
              style: GoogleFonts.cairo(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
    );
  }
}

class SimplePage extends StatelessWidget {
  final String title;

  const SimplePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "  Welcome to $title",
          style: GoogleFonts.cairo(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// ✅ حركة انزلاق عند الانتقال بين الصفحات
class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  SlidePageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0); // من الأسفل للأعلى
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          final tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
}
