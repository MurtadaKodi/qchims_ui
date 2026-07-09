import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:heritage_ui/screens/english/polygon_data_english.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

// Make sure polygonInfo is defined in polygon_data.dart and exported.
// If not, define it here as shown below and remove this comment block.
// Example definition (uncomment and edit as needed):
// final Map<String, String> polygonInfo = {
//   'Polygon1': 'Description for Polygon1',
//   'Polygon2': 'Description for Polygon2',
//   // Add more polygons as needed
// };

class FloatingPopupPolygonMap extends StatefulWidget {
  const FloatingPopupPolygonMap({super.key, required String title, required String username});

  @override
  State<FloatingPopupPolygonMap> createState() => _FloatingPopupPolygonMapState();
}

class _FloatingPopupPolygonMapState extends State<FloatingPopupPolygonMap>
    with TickerProviderStateMixin {
  static const double _mobileTabletBreakpoint = 700;
  static const double _controlsHeight = 52;
  static const double _controlsGapWide = 32;
  static const double _controlsGapMedium = 24;
  static const double _controlsGapCompact = 14;

  LatLng? tappedLocation;
  String? tappedPolygonName;
  String? selectedSupervisor;
  String? selectedSupervisorSiteLabel;
  double _zoom = 12.0;
  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
  }

  late final AnimatedMapController _animatedMapController;

  List<String> get _supervisors {
    final supervisors = polygons
        .map((polygon) => (polygon['supervisor'] ?? '').toString().trim())
        .where(
          (name) =>
              name.isNotEmpty &&
              !name.toLowerCase().startsWith('inspector') &&
              !name.startsWith('اسم المفتش'),
        )
        .toSet()
        .toList();
    supervisors.sort();
    return supervisors;
  }

  void _selectPolygonByLabel(String label) {
    final selected = polygons.firstWhere((loc) => loc['label'] == label);
    final LatLng point = selected['points'][0];

    setState(() {
      tappedPolygonName = label;
      selectedSupervisor = (selected['supervisor'] ?? '').toString().trim();
      selectedSupervisorSiteLabel = label;
    });

    _animatedMapController.animateTo(
      dest: point,
      zoom: 14.8,
      curve: Curves.linear,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _showSupervisorSitesDialog(String supervisorName) async {
    final sites = polygons.where((polygon) {
      final supervisor = (polygon['supervisor'] ?? '').toString().trim();
      return supervisor == supervisorName;
    }).toList();

    if (sites.isEmpty || !mounted) return;

    final selectedLabel = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Supervisor Sites: $supervisorName'),
          content: SizedBox(
            width: 360,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: sites.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (_, index) {
                final polygon = sites[index];
                final label = polygon['label'].toString();
                final name = polygon['name'].toString().trim();
                return ListTile(
                  title: Text(name),
                  subtitle: Text('HAR No: $label'),
                  trailing: const Icon(Icons.place_outlined),
                  onTap: () => Navigator.of(context).pop(label),
                );
              },
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
          ],
        );
      },
    );

    if (!mounted || selectedLabel == null) return;
    _selectPolygonByLabel(selectedLabel);
  }

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

  double _responsiveControlsGap(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return _controlsGapWide;
    if (width >= 900) return _controlsGapMedium;
    return _controlsGapCompact;
  }

  @override
  Widget build(BuildContext context) {
    final controlsGap = _responsiveControlsGap(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final shortestSide = MediaQuery.sizeOf(context).shortestSide;
    final isMobile = shortestSide < _mobileTabletBreakpoint;
    final mobileControlWidth = (screenWidth - 96).clamp(220.0, 340.0).toDouble();
    final locationDropdownWidth = isMobile ? mobileControlWidth : 280.0;
    final supervisorDropdownWidth = isMobile ? mobileControlWidth : 220.0;

    final locationControl = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4.0, offset: const Offset(0, 2))],
      ),
      child: SizedBox(
        height: _controlsHeight,
        width: locationDropdownWidth,
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
            hint: const Text('Select Site or HAR No'),
            value: null,
            items: polygons.map<DropdownMenuItem<String>>((loc) {
              return DropdownMenuItem<String>(
                value: loc['label'],
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: .5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outlined, color: Colors.black),
                      const SizedBox(width: 12),
                      Text('${loc['name']} (${loc['label']})'),
                    ],
                  ),
                ),
              );
            }).toList(),
            isExpanded: true,
            onChanged: (value) {
              if (value == null) return;
              _selectPolygonByLabel(value);
            },
          ),
        ),
      ),
    );

    final supervisorControl = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4.0, offset: const Offset(0, 2))],
      ),
      child: SizedBox(
        height: _controlsHeight,
        width: supervisorDropdownWidth,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            alignment: Alignment.center,
            menuWidth: double.infinity,
            menuMaxHeight: 400,
            isDense: true,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            iconEnabledColor: Colors.black,
            icon: const Icon(Icons.search, color: Colors.black),
            dropdownColor: Colors.white,
            hint: const Text('Search by supervisor'),
            value: null,
            items: _supervisors.map((name) {
              return DropdownMenuItem<String>(value: name, child: Text(name));
            }).toList(),
            isExpanded: true,
            onChanged: (value) async {
              if (value == null) return;
              setState(() {
                selectedSupervisor = value;
                selectedSupervisorSiteLabel = null;
              });
              await _showSupervisorSitesDialog(value);
              if (!mounted) return;
              setState(() {
                selectedSupervisor = null;
                selectedSupervisorSiteLabel = null;
              });
            },
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: isMobile ? (_controlsHeight * 2) + controlsGap + 20 : kToolbarHeight,
        centerTitle: true,
        title: isMobile
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  locationControl,
                  SizedBox(height: controlsGap),
                  supervisorControl,
                ],
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    locationControl,
                    SizedBox(width: controlsGap),
                    supervisorControl,
                  ],
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
            for (final polygon in polygons) {
              if (_pointInPolygon(latlng, polygon['points'])) {
                setState(() {
                  tappedPolygonName = polygon['label'];
                  selectedSupervisor = (polygon['supervisor'] ?? '').toString().trim();
                  selectedSupervisorSiteLabel = polygon['label'].toString();
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
                selectedSupervisorSiteLabel = null;
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
            polygons: polygons
                .map<Polygon>(
                  (polygon) => Polygon(
                    points: polygon['points'] as List<LatLng>,
                    // ignore: deprecated_member_use
                    color: tappedPolygonName == polygon['label']
                        ? (polygon['selectedColor'] ?? Colors.blue).withOpacity(0.2)
                        : (polygon['color'] ?? Colors.red).withOpacity(0.4),
                    borderStrokeWidth: polygon['borderStrokeWidth'] ?? 3.0,
                    borderColor: tappedPolygonName == polygon['label']
                        ? (polygon['isSelected'] ?? Colors.black)
                        : (polygon['color'] ?? Colors.red),
                    label: polygon['name'],
                    labelStyle: TextStyle(
                      color: polygon['labelColor'] ?? Colors.black, // Set label color here
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
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: GestureDetector(
                                      onTap: () {
                                        zoomInImage(
                                          polygons
                                              .firstWhere(
                                                (polygon) => polygon['label'] == tappedPolygonName,
                                              )['img']
                                              .toString(),
                                        );
                                        // Handle image tap if needed
                                      },
                                      child: Image.network(
                                        polygons
                                            .firstWhere(
                                              (polygon) => polygon['label'] == tappedPolygonName,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'HAR No: ${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['label']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'NAME: ${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['name']}',
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
                                        Column(
                                          children: [
                                            Text(
                                              'INSPECTOR/SUPERVISOR ',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade800,
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                              child: Text(
                                                '${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['supervisor']}',
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 20,
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
                                              'DESCRIPTION ',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              '${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['description']}',
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'WGS 95: \n ${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['wgs']}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'QNG: \n ${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['qng']}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'AREA: \n ${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['area']}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'PERIMETER: \n ${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['perimeter']}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                    Divider(color: Colors.grey[300]),
                                    const SizedBox(height: 8),
                                    Text(
                                      'MUNICIPALITY: \n ${polygons.firstWhere((polygon) => polygon['label'] == tappedPolygonName)['municipality']}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 18, color: Colors.white),
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
                                    polygons.firstWhere(
                                      (polygon) => polygon['label'] == tappedPolygonName,
                                    )['uri'],
                                  ),
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw 'Could not launch Maps';
                                }
                              },
                              child: const Text('Open in Maps'),
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
            right: 10,
            child: Column(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
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
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
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
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
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
