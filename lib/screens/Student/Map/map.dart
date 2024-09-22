import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Map_Screen extends StatefulWidget {
  const Map_Screen({super.key});

  @override
  State<Map_Screen> createState() => _Map_ScreenState();
}

class _Map_ScreenState extends State<Map_Screen> {
  String selectedName = '';
  String selectedName1 = '';
  String selectedStatus = '';
  String selectedSvgPath = '';
  double selectedMarkerLatitude = 0.0;
  double selectedMarkerLongitude = 0.0;
  bool isMarkerSelected = false;

  // Method to handle marker tap and update UI
  void _onMarkerTapped(
      String name, String name1, String status, String svgPath) {
    setState(() {
      selectedName = name;
      selectedName1 = name1;
      selectedStatus = status;
      selectedSvgPath = svgPath;
      isMarkerSelected = true;
    });
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      // Add more cases as needed
      default:
        return Colors.grey; // Default color
    }
  }

  // Method to handle map tap and hide marker info popup
  void _onMapTapped() {
    setState(() {
      isMarkerSelected = false;
    });
  }

  final MapController mapController = MapController();

  void moveToMarker(double latitude, double longitude) {
    mapController.move(LatLng(latitude, longitude),
        19.0,); // Adjust zoom level if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Stack(
          children: [
            FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: LatLng(7.198925, 100.6024488),
                  initialZoom: 17.00,
                  interactionOptions: const InteractionOptions(
                      flags: ~InteractiveFlag.doubleTapZoom),
                  onTap: (tapPosition, latLng) {
                    _onMapTapped(); // Hide the pop-up when tapping on the map
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(7.198425, 100.6023688),
                        width: 60,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            _onMarkerTapped("สาขาวิศวคอมพิวเตอร์", "มทร. สงขลา",
                                "Active", 'assets/svg/bottle_icon.svg');
                            moveToMarker(7.198425, 100.6023688);
                          },
                          child: Image.asset(
                              'assets/icons/bottle_location_icon.png'
                              // 'assets/icons/present_location_icon.png',
                              ),
                        ),
                      ),
                      Marker(
                        point: LatLng(7.198125, 100.6027788),
                        width: 60,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            _onMarkerTapped("อาคาร 59 ICT", "มทร. สงขลา",
                                "Inactive", 'assets/svg/present_icon.svg');
                            moveToMarker(7.198125, 100.6027788);
                          },
                          child: Image.asset(
                            // 'assets/icons/location_bottle_icon.png'
                            'assets/icons/present_location_icon.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
            if (isMarkerSelected)
              Positioned(
                bottom: 45,
                left: 15,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    // _onMapTapped(); // Optionally, also hide popup when tapping on the popup itself
                    moveToMarker(
                        selectedMarkerLatitude, selectedMarkerLongitude);
                  },
                  child: Stack(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              SvgPicture.asset(selectedSvgPath),
                              SizedBox(width: 10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedName,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    selectedName1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getStatusColor(
                                selectedStatus), // A function to determine color based on status
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35),
            ),
            // color: Colors.transparent
            color: Color(0xff00154B),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 25),
                  child: Text(
                    'ตำแหน่งเครื่องแลก',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
