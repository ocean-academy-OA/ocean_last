import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/webinar/countdown.dart';
import 'package:ocean_project/webinar/join_alert.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Webinar extends StatefulWidget {
  @override
  _WebinarState createState() => _WebinarState();
}

class _WebinarState extends State<Webinar> {
  WebinarAlert webinarAlert = WebinarAlert();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'images/webinar/webinar bg.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Container(
          height: 700,
          width: 1500,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: 1200,
                  height: 580,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 900,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cloud computing',
                              style: TextStyle(
                                  fontSize: 60,
                                  fontFamily: kfontname,
                                  color: Colors.grey[600]),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Cloud computing is the on-demand availability of computer system resources, especially data storage and computing power, without direct active management by the user. The term is generally used to describe data centers available to many users over the Internet.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: kfontname,
                                  color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Timer(
                            onPressed: () {
                              webinarAlert.displayDialog(context);
                            },
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image(
                                    image: NetworkImage(
                                        'images/webinar/register.svg')),
                                Positioned(
                                  left: 50,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Image(
                                      image: NetworkImage(
                                          'images/webinar/playIcon.svg'),
                                      width: 90,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 0,
                  child: Container(
                    height: 700,
                    width: 500,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 20,
                          child: Image(
                            image: NetworkImage('images/webinar/notebook.svg'),
                            height: 680,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
