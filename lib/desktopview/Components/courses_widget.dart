import 'dart:html';

import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ocean_project/alert/alert_msg.dart';

import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/download_pdf/download%20pdf.dart';

import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/course_details.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class CoursesWidget extends StatefulWidget {
  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  List<String> subjects = [];
  @override
  void initState() {
    // TODO: implement initState
    // getMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (Course.isSelected[0] == true)
            ? StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('offline_course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<OfflineCourse> offlineCourse = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageDuration = message.data()['duration'];
                      final messagePdflink = message.data()['pdflink'];
                      final messageImage = message.data()['img'];

                      final messageCourse = OfflineCourse(
                        trainername: messageText,
                        coursename: messageSender,
                        duration: messageDuration,
                        pdflink: messagePdflink,
                        image: messageImage,
                      );
                      // Text('$messageText from $messageSender');
                      offlineCourse.add(messageCourse);
                      subjects.add(message.data()["coursename"]);
                      print(subjects);
                    }

                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: offlineCourse,
                    );
                  }
                },
              )
            : StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<OnlineCourse> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageDuration = message.data()['duration'];
                      final messageTime = message.data()['time'];
                      final messageDate = message.data()['date'];
                      final messageImage = message.data()['img'];
                      final messageDescription =
                          message.data()['coursedescription'];
                      final messageBatchid = message.data()['batchid'];
                      final messageBubble = OnlineCourse(
                        trainername: messageText,
                        coursename: messageSender,
                        duration: messageDuration,
                        time: messageTime,
                        date: messageDate,
                        image: messageImage,
                        description: messageDescription,
                        batchid: messageBatchid,
                      );
                      // Text('$messageText from $messageSender');
                      messageBubbles.add(messageBubble);
                      subjects.add(message.data()["coursename"]);
                      print(subjects);
                    }

                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: messageBubbles,
                    );
                  }
                },
              ),
      ],
    );
  }
}

class OnlineCourse extends StatefulWidget {
  static bool visiblity = false;
  static String syllabusId;
  OnlineCourse(
      {this.coursename,
      this.trainername,
      this.duration,
      this.time,
      this.date,
      this.image,
      this.description,
      this.batchid});
  final String coursename;
  final String trainername;
  final String duration;
  final String time;
  final String image;
  final String description;
  final String batchid;
  final String date;

  @override
  _OnlineCourseState createState() => _OnlineCourseState();
}

class _OnlineCourseState extends State<OnlineCourse> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //studentId();
        print("${OnlineCourse.syllabusId}");
        print("${widget.coursename}jayalatha");
        print("jaya");
        setState(() {
          OnlineCourse.visiblity = true;
        });

        print(widget.coursename);
        Provider.of<Routing>(context, listen: false).updateRouting(
            widget: CourseDetails(
          batch: widget.batchid,
          course: widget.coursename,
          trainer: widget.trainername,
          sess: widget.time,
          desc: widget.description,
        ));
      },
      child: Container(
        margin: EdgeInsets.all(35.0),
        //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        height: 330.0,
        width: 350.0,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            Container(
              height: 200,
              width: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "${widget.coursename} full package course | ${widget.trainername} | Ocean Academy",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Color(0xff3B7EB6),
                      ),
                      Text(
                        "${widget.duration} hr",
                        style: otherSmallContentTextStyle,
                      ),
                      Icon(
                        Icons.web_sharp,
                        color: Color(0xff3B7EB6),
                      ),
                      Text(
                        "${widget.date}",
                        style: otherSmallContentTextStyle,
                      ),
                      Icon(
                        Icons.video_call,
                        color: Color(0xff3B7EB6),
                      ),
                      Text(
                        "${widget.time} P.M",
                        style: otherSmallContentTextStyle,
                      ),
                      // Text(
                      //   "Click Here",
                      //   style: TextStyle(
                      //       color: Color(0xff3B7EB6),
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: kfontname),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OfflineCourse extends StatefulWidget {
  static String userID;
  OfflineCourse({
    this.coursename,
    this.trainername,
    this.duration,
    this.pdflink,
    this.image,
  });
  final String coursename;
  final String trainername;
  final String duration;
  final String pdflink;
  final String image;

  @override
  _OfflineCourseState createState() => _OfflineCourseState();
}

class _OfflineCourseState extends State<OfflineCourse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(35.0),
      //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      height: 310.0,
      width: 350.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              image: NetworkImage('${widget.image}'),
              // width: 350.0,
              // height: 100.0,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "${widget.coursename} full package course | ${widget.trainername} | Ocean Academy",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  //mainAxisAli gnment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Color(0xff3B7EB6),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("${widget.duration} duration"),
                    SizedBox(
                      width: 30.0,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(05.0))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DownloadPDFAlert()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.download_sharp,
                            color: Color(0xff3B7EB6),
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Download pdf",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //alert starts from here..
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertEnquiry(
          queryField: false,
          buttonName: 'download',
          pdfLink: widget.pdflink,
        );
      },
    );
  }
}
