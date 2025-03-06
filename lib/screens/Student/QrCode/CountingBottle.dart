import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CountingBottle extends StatefulWidget {
  final String result;
  const CountingBottle({super.key, required this.result});

  @override
  State<CountingBottle> createState() => _CountingBottleState();
}

class _CountingBottleState extends State<CountingBottle> {
  late IOWebSocketChannel channel;
  int scanCount = 0;
  final String serverUrl = "http://192.168.137.21:3000/save-count";

  @override
  void initState() {
    super.initState();
    connectWebSocket();
  }

  void connectWebSocket() {
    channel = IOWebSocketChannel.connect('ws://192.168.137.21:8080');
    channel.stream.listen(
      (message) {
        if (message.startsWith("count:")) {
          setState(() {
            scanCount = int.tryParse(message.split(":").last) ?? scanCount;
          });
        }
      },
      onDone: () {
        print("WebSocket closed, reconnecting...");
        Future.delayed(
            Duration(seconds: 2), connectWebSocket); // Auto-reconnect
      },
      onError: (error) {
        print("WebSocket error: $error");
        Future.delayed(
            Duration(seconds: 2), connectWebSocket); // Auto-reconnect
      },
    );
  }

  Future<void> sendCountToDB() async {
    channel.sink.add("done:${widget.result}"); // Notify ESP32 to stop
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"user_id": widget.result, "count": scanCount}),
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
                  'Scanned QR Code: ${widget.result}',
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
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: SvgPicture.asset("assets/svg/bottle.svg",
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 200,
                              height: 200),
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
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2,
                                    letterSpacing: -0.5),
                              ),
                              Text(
                                "$scanCount",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 100,
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
                SizedBox(
                  height: 20,
                ),
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
                          padding: const EdgeInsets.only(left: 20),
                          child: SvgPicture.asset("assets/svg/piggy.svg",
                              color: Color.fromARGB(255, 255, 255, 255),
                              width: 90,
                              height: 90),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "แต้มสะสมทั้งหมด",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5),
                              ),
                              Text(
                                "159",
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
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    sendCountToDB();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "เสร็จสิ้น",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5),
                        ),
                      ],
                    )),
                    decoration: BoxDecoration(
                        color: Color(0xffFCCA00),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffEEC004),
                            spreadRadius: 1,
                            blurRadius: 0,
                            offset: const Offset(0, 4),
                          )
                        ]),
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
                        letterSpacing: -0.5),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
