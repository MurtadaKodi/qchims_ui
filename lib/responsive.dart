import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
    Padding padding, {
    super.key,
    required this.desktop,
    this.tablet,
    this.mobileLarg,
    required this.mobile,
  });

  final Widget desktop;
  final Widget? tablet;
  final Widget? mobileLarg;
  final Widget mobile;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 430;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < 1024;
  }

  static bool isMobileLarge(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1024) {
      return desktop;
    } else if (size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (size.width <= 450 && mobileLarg != null) {
      return mobileLarg!;
    } else {
      return mobile;
    }
  }
}
