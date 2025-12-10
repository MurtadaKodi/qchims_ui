import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:heritage_ui/screens/english/location_data_english.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyDropDown(title: '', onChanged: (value) {  }, items: [], onSelected: (value) {}));
  }
}

class MyDropDown extends StatefulWidget {
  const MyDropDown({super.key, required String title, required Null Function(String?) onChanged, required List<DropdownMenuItem<String>> items, required Null Function(String?) onSelected});

  @override
  // ignore: library_private_types_in_public_api
  _MyDropDownState createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {

String? selectedValue; // القيمة المختارة

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // القائمة المنسدلة مع Scroll
        DropdownButtonFormField<String>(
          focusColor: Colors.white,
          isExpanded: true, // يخلي العرض كامل
          menuMaxHeight: 300, // أقصى ارتفاع للقائمة (مع Scroll)
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            labelText: "Select Site",
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          initialValue: selectedValue,
          items: englishData.map((marker) {
            return DropdownMenuItem<String>(
              value: marker['name'],
              child: Text(marker['name']),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue;
        
            });
          },
        ),
      ],
    );
  }
}

class MyMarker {
  final String name;
  final LatLng point;
  final String title;
  final String description;
  final String uri;
  final Color color;
  final IconData icon;
  final String img;

  MyMarker({
    required this.name,
    required this.point,
    required this.title,
    required this.description,
    required this.uri,
    required this.color,
    required this.icon,
    required this.img, required List<dynamic> myMarkers,
  });
}
