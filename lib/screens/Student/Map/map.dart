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
      default:
        return Colors.grey; 
    }
  }

  void _onMapTapped() {
    setState(() {
      isMarkerSelected = false;
    });
  }

  final MapController mapController = MapController();

  void moveToMarker(double latitude, double longitude) {
    mapController.move(
      LatLng(latitude, longitude),
      18.0,
    ); 
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
                    flags: ~InteractiveFlag.rotate 
                  ),
                  onTap: (tapPosition, latLng) {
                    _onMapTapped(); 
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c', 'd'],
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
                                "Inactive", 'assets/svg/reward_icon.svg');
                            moveToMarker(7.198125, 100.6027788);
                          },
                          child: Image.asset(
                            'assets/icons/reward_location_icon.png',
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
                    //tap on selected marker
                    // moveToMarker(
                    //     selectedMarkerLatitude, selectedMarkerLongitude);
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
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    selectedName1,
                                    style: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0,
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
                                selectedStatus),
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
      preferredSize: Size.fromHeight(85),
      child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35),
            ),
            color: Color(0xff00154B),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Text(
                    'ตำแหน่งเครื่องแลก',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
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
