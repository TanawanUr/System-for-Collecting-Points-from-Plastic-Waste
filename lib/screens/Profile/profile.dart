import 'package:flutter/material.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(35),
              ),
              color: Color(0xff00154B)
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage("assets/images/profile.png"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "ธนวันต์ อุรามา",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        height: 1.7,
                      ),
                    ),
                    Text(
                      "164404140076",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      "คณะ วิศวกรรมศาสตร์",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      "สาขา วิศวกรรมคอมพิวเตอร์",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      height: 0,
                      thickness: 0,
                      indent: 100,
                      endIndent: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
              child: Column(
                  children: [
                      InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const BottomNavBar()),
                            // );
                          },
                          child: Container(
                            width: 400,
                            height: 50,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ตั้งค่า',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            )),
                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                    bottom: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(63, 0, 0, 0),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 1),
                                  )
                                ]
                              ),
                          ),
                        ),
                      SizedBox(height: 15,),
                      InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const BottomNavBar()),
                            // );
                          },
                          child: Container(
                            width: 360,
                            height: 50,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'ออกจากระบบ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            )),
                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10),
                                    bottom: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(63, 0, 0, 0),
                                    spreadRadius: 0,
                                    blurRadius: 5,
                                    offset: const Offset(0, 1),
                                  )
                                ]
                              ),
                          ),
                        ),
              
                  ],
                ),
            ),
        ],
      ),
      backgroundColor: Color(0xffEAEAEA),
    );
  }
}
