
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:heritage_ui/screens/english/location_data_english.dart' as location_data;
import 'package:url_launcher/url_launcher.dart';

class LocationMapEnglish extends StatefulWidget {
  const LocationMapEnglish({super.key, required String title, required String username});

  @override
  // ignore: library_private_types_in_public_api
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMapEnglish>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  final PopupController _popupController = PopupController();


  String? _selectedName;
  
  double _zoom = 12.0;

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          hint: Text("Select Location"),
          value: _selectedName,
          items: location_data.englishData.map((loc) {
            return DropdownMenuItem<String>(
              value: loc["name"],
              child: Text(loc["name"]),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedName = value;
            });

            // Find the marker by name
            final selected = location_data.englishData.firstWhere(
              (loc) => loc["name"] == value,
            );
            final LatLng point = selected["point"];

            // Animate to marker (smooth move)
            _animatedMapController.animateTo(
              dest: point,
              zoom: 13,
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 1),
            );

            // Show popup automatically
            _popupController.hideAllPopups();
            Future.delayed(Duration(milliseconds: 600), () {
              final marker = Marker(
                point: point,
                width: 50,
                height: 50,
                child: Icon(Icons.location_pin, color: Colors.blue, size: 45),
              );
              _popupController.showPopupsOnlyFor([marker]);
            });
          },
        ),
        centerTitle: true,
      ),
      body: FlutterMap(
        mapController: _animatedMapController.mapController,
        options: MapOptions(
          initialCenter: LatLng(25.455759, 51.231191),
          initialZoom: 9,
          onTap: (_, _) => _popupController.hideAllPopups(),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
            subdomains: ['a', 'b', 'c'],
          ),

          /// Popup Marker Layer
          // ignore: deprecated_member_use
          PopupMarkerLayerWidget(
            options: PopupMarkerLayerOptions(
              popupController: _popupController,
              markers: location_data.englishData.map((loc) {
                bool isSelected = loc["name"] == _selectedName;
                return Marker(
                  point: loc["point"],
                  width: isSelected ? 50 : 40,
                  height: isSelected ? 50 : 40,
                  child: Icon(isSelected
                      ? Icons.location_pin
                      : Icons.location_on,
                    // Icons.location_pin,
                    color: isSelected ? Colors.blue : Colors.red,
                    size: isSelected ? 45 : 25,
                  ),
                );
              }).toList(),
              popupDisplayOptions: PopupDisplayOptions(
                builder: (BuildContext context, Marker marker) {
                  final markerData = location_data.englishData.firstWhere(
                    (m) => m['point'] == marker.point,
                    orElse: () => {
                      'title': '',
                      'description': '',
                      'uri': '',
                      'img': '',
                      'point': LatLng(0, 0),
                      'name': '',
                      'id': 0,
                      'icon': Icons.location_on,
                    },
                  );
                  return Stack(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  markerData['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      if (!await launchUrl(
                                        Uri.parse(markerData['uri']),
                                        mode: LaunchMode.externalApplication,
                                      )) {}
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        markerData['img'],
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(markerData['description']),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (!await launchUrl(
                                      Uri.parse(markerData['uri']),
                                      mode: LaunchMode.externalApplication,
                                    )) {}
                                  },
                                  child: Text('Let\'s Go'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 10,
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.black),
                    padding: WidgetStateProperty.all(EdgeInsets.all(20)),
                  ),
                  onPressed: () {
                    setState(() {
                      _zoom += .2;
                      _animatedMapController.mapController.move(_animatedMapController.mapController.camera.center, _zoom);
                    });
                  },
                  child: Icon(Icons.add, color: Colors.white, size: 30),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    padding: WidgetStateProperty.all(EdgeInsets.all(20)),
                  ),
                  onPressed: () {
                    setState(() {
                      _zoom -= .2;
                      _animatedMapController.mapController.move(_animatedMapController.mapController.camera.center, _zoom);
                    });
                  },
                  child: Icon(Icons.remove, color: Colors.white, size: 30),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    padding: WidgetStateProperty.all(EdgeInsets.all(20)),
                  ),
                  onPressed: () {
                    setState(() {
                      // Reset zoom to default value
                      _zoom = 9.2;
                      _animatedMapController.mapController.move(_animatedMapController.mapController.camera.center, _zoom);
                    });
                  },
                  child: Icon(Icons.home, color: Colors.white, size: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
