import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminSummaryPage extends StatelessWidget {
  const AdminSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              toolbarHeight: 70,
              backgroundColor: Color(0xff00154B),
              leading: IconButton(
                icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
                // icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'ข้อมูลสรุประบบทั้งหมด',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(35),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            
                            Text("รายการล่าสุด",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                )
                              ),
                            IconButton(
                              onPressed: (){
                        
                              }, 
                              icon: FaIcon(
                                FontAwesomeIcons.arrowDownShortWide,
                                size: 25,
                                 color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}