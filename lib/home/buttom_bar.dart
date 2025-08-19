import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtomBar extends StatelessWidget {
  const ButtomBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Items> items = [
      Items(text: "Home", icon: Icons.home, url: "https://www.youtube.com"),
      Items(
        text: "Facebook",
        icon: Icons.facebook,
        url: "https://www.facebook.com",
      ),
      Items(text: "Google", icon: Icons.web, url: "https://www.google.com"),
      Items(text: "GitHub", icon: Icons.person, url: "https://www.github.com"),
    ];

    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      color: Colors.blue,
      height: 60,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 300),
      items: items
          .map(
            (item) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white),
                Text(
                  item.text,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          )
          .toList(),
      index: 0,
      onTap: (index) => _launchURL(items[index].url),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {}
  }
}

extension on List<Items> {}

class Items {
  final String text;
  final IconData icon;
  final String url;

  Items({required this.text, required this.icon, required this.url});
}
