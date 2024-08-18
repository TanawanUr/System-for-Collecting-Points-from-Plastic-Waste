import 'package:flutter/material.dart';

class Profile_Screen extends StatelessWidget {
  const Profile_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(35),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 18, 63),
              Color.fromARGB(255, 0, 30, 105)
            ],
          ),
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
      backgroundColor: Color(0xffEAEAEA),
    );
  }
}
