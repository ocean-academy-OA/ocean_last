import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/Components/main_title_widget.dart';
import 'package:ocean_project/mobileview/components/ocean_icons.dart';

class UpcomingCourse extends StatefulWidget {
  @override
  _UpcomingCourseState createState() => _UpcomingCourseState();
}

class _UpcomingCourseState extends State<UpcomingCourse> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Positioned(
        //   top: -50,
        //   left: -0,
        //
        //   child: Icon(
        //     Ocean.oa,
        //     size: 400.0,
        //     color: Colors.lightBlue[200],
        //
        //
        //   ),
        // ),
        // Positioned(
        //   top: 300,
        //   left: -120,
        //   child: Icon(
        //     Icons.circle,
        //     size: 200.0,
        //     color: Colors.pinkAccent,
        //   ),
        // ),
        // Positioned(
        //   top: 500,
        //   left: 420,
        //   child: Icon(
        //     Icons.circle,
        //     size: 200.0,
        //     color: Colors.lime,
        //   ),
        // ),
        // Positioned(
        //   top: 200,
        //   right: 400,
        //   child: Icon(
        //     Icons.circle,
        //     size: 180.0,
        //     color: Colors.lightBlue,
        //   ),
        // ),
        // Positioned(
        //     top: 0,
        //     right: 380,
        //     child: Text(
        //       '°',
        //       style: TextStyle(fontSize: 100, color: Colors.yellow),
        //     )),
        // Positioned(
        //   top: 70,
        //   right: 330,
        //   child: Transform.rotate(
        //       angle: -170.2,
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.purple,
        //           borderRadius: BorderRadius.circular(5.0),
        //         ),
        //         height: 10.0,
        //         width: 100.0,
        //       )),
        // ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/oa_bg-01.png'))),
          padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: MainTitleWidget(
                  title: "Upcoming Courses",
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('course').snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading.....");
                        } else {
                          final messages = snapshot.data.docs;
                          List<UpcomingCoursesImages> bubbles = [];

                          for (var message in messages) {
                            final messageImage = message.data()['img'];
                            final bubble = UpcomingCoursesImages(
                              imagePath: messageImage,
                            );
                            // Text('$messageText from $messageSender');
                            bubbles.add(bubble);
                          }
                          return Wrap(
                            children: bubbles,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UpcomingCoursesImages extends StatelessWidget {
  UpcomingCoursesImages({this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100.0,
      // height: 100.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          height: 300.0,
          child: Image(
            image: NetworkImage("$imagePath"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
