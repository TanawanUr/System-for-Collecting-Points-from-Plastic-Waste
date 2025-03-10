import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/navbar.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class CountingBottle extends StatefulWidget {
  final String result; // ESP ID
  final String userId;
    const CountingBottle({super.key, required this.result, required this.userId});

  @override
  State<CountingBottle> createState() => _CountingBottleState();
}

class _CountingBottleState extends State<CountingBottle> {
  late IOWebSocketChannel channel;
  int scanCount = 0;
  Image? image;
  final String serverUrl = "http://192.168.137.21:3000/save-count";

  @override
  void initState() {
    super.initState();
    connectWebSocket();
  }

  void connectWebSocket() {
    channel = IOWebSocketChannel.connect('ws://192.168.1.132:8080');

    channel.sink.add("user:${widget.userId}"); // Send user ID
    channel.sink.add("start"); // Start automatic counting on ESP32

    channel.stream.listen(
      (message) {
        if (message.startsWith("count:")) {
          setState(() {
            scanCount = int.tryParse(message.split(":").last) ?? scanCount;
          });
        } else if (message.startsWith("image:")) {
        String base64Image = message.substring(6);
        Uint8List imageBytes = base64Decode(base64Image);
        setState(() {
          image = Image.memory(imageBytes);  // Store image in UI
        });
      }
      },
      onDone: () {
        print("WebSocket closed.");
      },
      onError: (error) {
        print("WebSocket error: $error");
      },
    );
  }

  void sendScanSignal() {
    channel.sink.add("scan");
  }

  Future<void> sendCountToDB() async {
    channel.sink.add("done"); // Notify ESP32 to stop
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"user_id": widget.userId, "count": scanCount}),
    );
    if (response.statusCode == 200) {
      print("Data sent successfully");
    } else {
      print("Failed to send data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEAEA),
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(
                  'UserID: ${widget.userId}',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    height: 320,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color(0xff00154B),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(35),
                          bottom: Radius.circular(35)),
                    ),
                    
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color(0xffFCCA00),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(35),
                          bottom: Radius.circular(35)),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: SvgPicture.asset("assets/svg/bottle.svg",
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 90,
                              height: 90),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "จำนวนขวด\nพลาสติกตอนนี้",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 26,
                                    height: 1,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5),
                              ),
                              Text(
                                "$scanCount",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 50,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    sendCountToDB();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffFCCA00),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffEEC004),
                          spreadRadius: 1,
                          blurRadius: 0,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "เสร็จสิ้น",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
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
                margin: EdgeInsets.fromLTRB(0, 15, 0, 25),
                child: Text(
                  'ใส่ขวดในเครื่อง...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
