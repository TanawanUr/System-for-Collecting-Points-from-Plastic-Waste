import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Student/navbar.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List

class CountingBottle extends StatefulWidget {
  final String result; // ESP ID
  final String userId;
  const CountingBottle({super.key, required this.result, required this.userId});

  @override
  State<CountingBottle> createState() => _CountingBottleState();
}

class _CountingBottleState extends State<CountingBottle> {
  final channel = IOWebSocketChannel.connect('ws://192.168.1.198:8080');
  int scanCount = 0;
  String imageUrl = '';
  Image? _image;

  @override
  void initState() {
    super.initState();
    // Check if connection is successful
    channel.stream.listen((message) {
      print("Received: $message");
      if (message.startsWith("COUNT:")) {
        setState(() => scanCount = int.parse(message.split(":")[1]));
      } else if (message.startsWith("IMAGE:")) {
        String base64Image = message.split(":")[1];
        Uint8List bytes = base64Decode(base64Image);

        // Now, you can display the image using Image.memory in Flutter
        setState(() {
          _image = Image.memory(bytes);
        });
      }
    }, onDone: () {
      print("WebSocket connection closed");
    }, onError: (error) {
      print("WebSocket error: $error");
    });

    channel.sink.add("FLUTTER_CONNECTED");
    sendUserID(widget.userId);
  }

  void sendUserID(String userID) {
    channel.sink.add("USER_ID:$userID");
  }

  void fetchImage() {
    setState(() => imageUrl = "http://192.168.1.123/uploads/latest.jpg");
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
                    child: _image == null
                        ? Center(
                            child: Text('ยังไม่ได้รับรูปภาพ',
                                style: TextStyle(color: Colors.white)))
                        : ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(35),
                              bottom: Radius.circular(35),
                            ),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: _image,
                            ),
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
