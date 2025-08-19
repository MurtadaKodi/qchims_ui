import 'package:flutter/material.dart';
import 'package:flutter_application_02/sites/location_data.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(LocationMap(title: '',));

class LocationMap extends StatelessWidget {
  const LocationMap({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Location Map'),
        backgroundColor: Colors.blue,
      ),
      body: MapScreen());
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final PopupController _popupController = PopupController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(25.455759, 51.231191),
          initialZoom: 9,
          onTap: (_, _) => _popupController.hideAllPopups(),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              
              markers: myMarkers
                  .map(
                    (data) => Marker(
                      point: data.point,
                      width: 15,
                      height: 10,
                      child: GestureDetector(
                        onTap: () {
                          _popupController.showPopupsOnlyFor([
                            Marker(
                              point: data.point,
                              width: 20,
                              height: 20,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ]);
                        },
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              popupController: _popupController,
              popupDisplayOptions: PopupDisplayOptions(
                builder: (BuildContext context, Marker marker) {
                  final markerData = myMarkers.firstWhere(
                    (m) => m.point == marker.point,
                    orElse: () => MyMarker(
                      point: LatLng(0, 0),
                      title: '',
                      description: '',
                      nav: (context) {},
                    ),
                  );
                  return Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                markerData.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(markerData.description),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


