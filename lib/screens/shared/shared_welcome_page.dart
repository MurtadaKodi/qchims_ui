// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heritage_ui/main.dart';
import 'package:heritage_ui/screens/arabic/management_area_arabic.dart';
import 'package:heritage_ui/screens/arabic/polygon_map_arabic.dart';
import 'package:heritage_ui/screens/english/management_area_english.dart';
import 'package:heritage_ui/screens/english/polygon_map_english.dart';
import 'package:heritage_ui/screens/shared/app_language.dart';
import 'package:heritage_ui/screens/shared/app_strings.dart';

class SharedWelcomePage extends StatelessWidget {
  const SharedWelcomePage({super.key, required this.language});

  final AppLanguage language;

  Widget _buildMenuAction({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    TextStyle? style,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label, style: style),
    );
  }

  void _toggleLanguage(BuildContext context) {
    final target = language.isArabic ? AppLanguage.english : AppLanguage.arabic;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SharedWelcomePage(language: target)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = language.isArabic;
    final text = AppStrings.of(language);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(text.welcomeAppBarTitle, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.toggle_on, color: Colors.white, size: 30),
            tooltip: text.toggleToOtherLanguage,
            onPressed: () => _toggleLanguage(context),
          ),
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 30),
            tooltip: text.homeTooltip,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => MainApp()));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
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
                  Text(
                    text.welcomeMessage,
                    style: GoogleFonts.cairo(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
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
                    child: isArabic
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildMenuAction(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PolygonMapArabic(title: '', username: ''),
                                    ),
                                  );
                                },
                                icon: Icons.info_outline,
                                label: text.heritageInfo,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildMenuAction(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ManagementAreaArabic(title: '', username: ''),
                                    ),
                                  );
                                },
                                icon: Icons.settings,
                                label: text.managementArea,
                                style: GoogleFonts.cairo(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildMenuAction(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FloatingPopupPolygonMap(title: '', username: ''),
                                    ),
                                  );
                                },
                                icon: Icons.info_outline,
                                label: text.heritageInfo,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 12),
                              _buildMenuAction(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ManagementAreaEnglish(),
                                    ),
                                  );
                                },
                                icon: Icons.settings,
                                label: text.managementArea,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(22.0),
            child: Text(
              text.footerCopyright,
              style: GoogleFonts.cairo(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
