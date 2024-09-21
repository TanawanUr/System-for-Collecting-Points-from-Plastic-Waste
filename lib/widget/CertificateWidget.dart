import 'package:flutter/material.dart';

class CertificateWidget extends StatelessWidget {
  const CertificateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child : Column(
          children: [
            Container(
              width: 450,
              padding: EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/certificate.png',
                    width: 230,
                    height: 230,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'เกียรติบัตร',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '250 แต้ม',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '64/200',
                            style: TextStyle(
                              color: Color(0xff136BFF),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 80,
                      height: 35,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "แลก",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
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
                              offset: const Offset(0, 2),
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}
