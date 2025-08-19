import 'package:flutter/material.dart';

import 'package:latlong2/latlong.dart';

List<MyMarker> get myMarkers => [
  MyMarker(
    point: LatLng(25.9771068, 51.0453357),
    title: "Al Zubara - أطلال الزبارة",
    description: "Al Zubara Fort, a UNESCO World Heritage Site",
    nav: (context) {
      Navigator.pushNamed(context, '/zubara_myhome_page');
    },
  ),
  MyMarker(
    point: LatLng(26.0037699, 51.0553029),
    title: "Ain Mohamed - قرية عين محمد",
    description: "Ain Mohamed, a historical site",
    nav: (context) {},
  ),
  MyMarker(
    point: LatLng(26.0858459, 51.1570112),
    title: "Lujmail - الجميل",
    description: "Lujmail, a historical site",
    nav: (context) {
      Navigator.pushNamed(context, '/lujmail');
    },
  ),
  MyMarker(
    point: LatLng(26.134798, 51.303231),
    title: "Al Mfjar - المفجر",
    description: "Al Mfjar, a city with rich history",
    nav: (context) {
      Navigator.pushNamed(context, '/al_mfjar');
    },
  ),
  MyMarker(
    point: LatLng(25.859765,51.0314829),
    title: "Marwab - حصن مروب",
    description: "Marwab, a city with rich history",
    nav: (context) {
      Navigator.pushNamed(context, '/al_wakrah');
    },
  ),
  MyMarker(
    point: LatLng(25.490230, 50.844352),
    title: "Zkreet - زكريت",
    description: "Zkreet, a city with rich history",
    nav: (context) {
      Navigator.pushNamed(context, '/zkreet');
    },
  ),
];

/* Removed invalid extension method that caused a syntax error */

class MyMarker {
  final LatLng point;
  final String title;
  final String description;
  final void Function(BuildContext) nav;

  MyMarker({
    required this.point,
    required this.title,
    required this.description,
    required this.nav,
  });
}
