import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/marker_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Map_Screen extends StatefulWidget {
  const Map_Screen({super.key});

  @override
  State<Map_Screen> createState() => _Map_ScreenState();
}

class _Map_ScreenState extends State<Map_Screen> {
  String selectedName = '';
  String selectedName1 = '';
  String selectedStatus = 'Inactive'; // Default status
  String selectedSvgPath = '';
  double selectedMarkerLatitude = 0.0;
  double selectedMarkerLongitude = 0.0;
  bool isMarkerSelected = false;

  List<MarkerWidget> historyItems = [
    MarkerWidget(
      lat: 7.198425,
      lng: 100.6023688,
      location: 'สาขาวิศวคอมพิวเตอร์',
      location1: 'มทร. สงขลา',
      status: 'Inactive', // Initially set as Inactive
      type: 'bottle',
    ),
    MarkerWidget(
      lat: 7.198125,
      lng: 100.6027788,
      location: 'อาคาร 59 ICT',
      location1: 'มทร. สงขลา',
      status: 'Disable', // Initially set as Inactive
      type: 'reward',
    ),
  ];

  @override
  void initState() {
    super.initState();
    fetchStatusFromApi(); // Fetch the status from the API
  }

Future<void> fetchStatusFromApi() async {
  try {
    final response =
        await http.get(Uri.parse('http://192.168.196.21:3000/esp-status'));

    if (response.statusCode == 200) {
      // Decode the response body as a map
      Map<String, dynamic> data = json.decode(response.body);

      // Extract the 'status' value from the response
      String status = data['status'];

      setState(() {
        // Update the status of the marker based on the response
        for (var marker in historyItems) {
          // Match the marker based on location or any unique identifier
          if (marker.location == 'สาขาวิศวคอมพิวเตอร์') {
            marker.status = status; // Update status
          }
        }
      });
    } else {
      throw Exception('Failed to load status');
    }
  } catch (e) {
    print('Error fetching status: $e');
  }
}


  // Function to add a new marker manually (this still uses the static data)
  void addNewMarker(
      double lat, double lng, String location, String location1, String type) {
    setState(() {
      historyItems.add(MarkerWidget(
        lat: lat,
        lng: lng,
        location: location,
        location1: location1,
        status: 'Inactive', // Initially set as Inactive
        type: type,
      ));
    });
    // After adding, fetch the status from API again
    fetchStatusFromApi();
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
                options: MapOptions(
                  initialCenter: LatLng(7.198925, 100.6024488),
                  initialZoom: 17.00,
                  interactionOptions:
                      const InteractionOptions(flags: ~InteractiveFlag.rotate),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c', 'd'],
                  ),
                  MarkerLayer(
                    markers: historyItems.map((item) {
                      return Marker(
                        point: LatLng(item.lat, item.lng),
                        width: 60,
                        height: 60,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            _onMarkerTapped(
                              item.location,
                              item.location1,
                              item.status,
                              'assets/svg/${item.type}_icon.svg',
                            );
                            fetchStatusFromApi();
                          },
                          child: Image.asset(
                            'assets/icons/${item.type}_location_icon.png',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ]),
            if (isMarkerSelected)
              Positioned(
                bottom: 45,
                left: 15,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    fetchStatusFromApi();
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
                          padding: const EdgeInsets.only(
                              left: 15, top: 15, bottom: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset(selectedSvgPath),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      selectedName,
                                      style: TextStyle(
                                          fontSize: 22,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w700,
                                          height: 1.1),
                                      overflow: TextOverflow.ellipsis,
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
                            color: getStatusColor(selectedStatus),
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

  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      case 'Disable':
        return Colors.white;
      default:
        return Colors.grey;
    }
  }

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
}
