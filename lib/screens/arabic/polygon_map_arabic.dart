import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:heritage_ui/screens/arabic/polygon_data_arabic.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

// Make sure polygonInfo is defined in polygon_data.dart and exported.
// If not, define it here as shown below and remove this comment block.
// Example definition (uncomment and edit as needed):
// final Map<String, String> polygonInfo = {
//   'Polygon1': 'Description for Polygon1',
//   'Polygon2': 'Description for Polygon2',
//   // Add more polygonArabic as needed
// };

class PolygonMapArabic extends StatefulWidget {
  const PolygonMapArabic({
    super.key,
    required String title,
    required String username,
  });

  @override
  State<PolygonMapArabic> createState() => _PolygonMapArabicState();
}

class _PolygonMapArabicState extends State<PolygonMapArabic>
    with TickerProviderStateMixin {
  LatLng? tappedLocation;
  String? tappedPolygonName;
  double _zoom = 12.0;
  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
  }

  late final AnimatedMapController _animatedMapController;

  void zoomInImage(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: InteractiveViewer(child: Image.network(imageUrl)),
        ),
      ),
    );
  }

  // Ray-casting algorithm for point-in-polygon
  bool _pointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersectCount = 0;
    for (int j = 0; j < polygon.length; j++) {
      LatLng a = polygon[j];
      LatLng b = polygon[(j + 1) % polygon.length];
      if (((a.latitude > point.latitude) != (b.latitude > point.latitude)) &&
          (point.longitude <
              (b.longitude - a.longitude) *
                      (point.latitude - a.latitude) /
                      (b.latitude - a.latitude) +
                  a.longitude)) {
        intersectCount++;
      }
    }
    return (intersectCount % 2) == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              alignment: Alignment.center,
              menuWidth: double.infinity,
              menuMaxHeight: 500,
              itemHeight: null,
              isDense: false,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
              dropdownColor: Colors.white,
              hint: const Text('حدد الموقع أو رقم المنطقة  '),
              value: tappedPolygonName,
              items: polygonArabic.map<DropdownMenuItem<String>>((loc) {
                return DropdownMenuItem<String>(
                  value: loc["label"],
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: .5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outlined, color: Colors.black),
                        SizedBox(width: 12),
                        Text('${loc["name"]} (${loc["label"]})'),
                      ],
                    ),
                  ),
                );
              }).toList(),
              isExpanded: true,
              onChanged: (value) {
                setState(() {
                  tappedPolygonName = value;
                  // Find the polygon by label
                  final selected = polygonArabic.firstWhere(
                    (loc) => loc["label"] == value,
                  );
                  final LatLng point = selected["points"][0];

                  // Animate to polygon center (smooth move)
                  _animatedMapController.animateTo(
                    dest: point,
                    zoom: 14.8,
                    curve: Curves.linear,
                    duration: const Duration(seconds: 2),
                  );
                });
              },
            ),
          ),
        ),
      ),
      body: FlutterMap(
        mapController: _animatedMapController.mapController,
        options: MapOptions(
          initialCenter: const LatLng(25.365298, 51.195988),
          initialZoom: 9,
          onTap: (_, latlng) {
            // Check if tap is inside any polygon
            bool found = false;
            for (final polygon in polygonArabic) {
              if (_pointInPolygon(latlng, polygon['points'])) {
                setState(() {
                  tappedPolygonName = polygon['label'];
                  tappedLocation = latlng;
                });
                found = true;
                break;
              }
            }
            if (!found) {
              // Clear popup when tapping outside
              setState(() {
                tappedLocation = null;
                tappedPolygonName = null;
              });
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
            userAgentPackageName: 'com.example.app',
          ),

          PolygonLayer(
            polygons: polygonArabic
                .map<Polygon>(
                  (polygon) => Polygon(
                    points: polygon['points'] as List<LatLng>,
                    // ignore: deprecated_member_use
                    color: tappedPolygonName == polygon['label']
                        ? (polygon['selectedColor'] ?? Colors.blue).withOpacity(
                            0.2,
                          )
                        : (polygon['color'] ?? Colors.red).withOpacity(0.4),
                    borderStrokeWidth: polygon['borderStrokeWidth'] ?? 3.0,
                    borderColor: tappedPolygonName == polygon['label']
                        ? (polygon['isSelected'] ?? Colors.black)
                        : (polygon['color'] ?? Colors.red),
                    label: polygon['name'],
                    labelStyle: TextStyle(
                      color:
                          polygon['labelColor'] ??
                          Colors.black, // Set label color here
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
                .toList(),
            polygonCulling: false,
          ),
          if (tappedLocation != null && tappedPolygonName != null)
            Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 22.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: GestureDetector(
                                      onTap: () {
                                        zoomInImage(
                                          polygonArabic
                                              .firstWhere(
                                                (polygon) =>
                                                    polygon['label'] ==
                                                    tappedPolygonName,
                                              )['img']
                                              .toString(),
                                        );
                                        // Handle image tap if needed
                                      },
                                      child: Image.network(
                                        polygonArabic
                                            .firstWhere(
                                              (polygon) =>
                                                  polygon['label'] ==
                                                  tappedPolygonName,
                                            )['img']
                                            .toString(),
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      ' رقم  المنطقة التراثية  :  ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['label']}',
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      ' اسم الموقع الأثري  :  ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['name']}',
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: double.infinity,
                                          child: Text(
                                            'اسم المفتش/المشرف ',
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          width: double.infinity,
                                          color: Colors.grey.shade800,
                                          child: Text(
                                            ' ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['supervisor']}',
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Column(
                                      children: [
                                        Text(
                                          'وصف الموقع ',
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          '${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['description']}',
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      ' إحداثيات الموقع بالنظام العالمي \n \n ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['wgs']}',
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'إحداثيات الموقع بالنظام القطري\n \n ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['qng']}',
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'المساحة \n \n ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['area']}',
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'المحيط \n \n ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['perimeter']}',
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'البلدية \n \n ${polygonArabic.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['municipality']}',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () async {
                                if (!await launchUrl(
                                  Uri.parse(
                                    polygonArabic.firstWhere(
                                      (polygon) =>
                                          polygon['label'] == tappedPolygonName,
                                    )['uri'],
                                  ),
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw 'Could not launch Maps';
                                }
                              },
                              child: const Text('انتقل إلى الموقع'),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          Positioned(
            bottom: 16,
            left: 10,
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
                      _animatedMapController.mapController.move(
                        _animatedMapController.mapController.camera.center,
                        _zoom,
                      );
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
                      _animatedMapController.mapController.move(
                        _animatedMapController.mapController.camera.center,
                        _zoom,
                      );
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
                      _zoom = 9;
                      _animatedMapController.mapController.move(
                        const LatLng(25.365298, 51.195988),
                        _zoom,
                      );
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
