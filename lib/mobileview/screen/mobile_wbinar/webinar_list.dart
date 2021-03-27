import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/mobileview/screen/home_screen.dart';
import 'package:ocean_project/mobileview/screen/mobile_wbinar/mobile_single%20webinar.dart';
import 'package:ocean_project/webinar/single_wbinar.dart';
import 'package:provider/provider.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MobileWebinarCard extends StatefulWidget {
  @override
  _MobileWebinarCardState createState() => _MobileWebinarCardState();
}

class _MobileWebinarCardState extends State<MobileWebinarCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upcoming Webinars'),
        leading: BackButton(),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('Webinar').snapshots(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
            } else {
              final messages = snapshot.data.docs;

              List<WebinarCardDb> courseList = [];
              List<int> timingList = [];
              Map<int, Widget> courseMap = {};
              for (var message in messages) {
                Timestamp timeStamp = message.data()['timestamp'];

                final courseName = message.data()['course'];
                final trainerName = message.data()['trainer name'];

                final payment = message.data()['payment'];
                final designation = message.data()['designation'];
                final trainerImage = message.data()['trainer image'];
                print(timeStamp);
                print(DateTime.now().millisecond);

                int yearFormat;
                int monthFormat;
                int dayFormat;
                int hourFormat;
                int minuteFormat;
                int secondsFormat;

                var year = DateFormat('y');
                var month = DateFormat('MM');
                var day = DateFormat('d');
                var hour = DateFormat('hh');
                var minute = DateFormat('mm');
                var seconds = DateFormat('s');

                yearFormat = int.parse(year.format(timeStamp.toDate()));
                monthFormat = int.parse(month.format(timeStamp.toDate()));
                dayFormat = int.parse(day.format(timeStamp.toDate()));
                hourFormat = int.parse(hour.format(timeStamp.toDate()));
                minuteFormat = int.parse(minute.format(timeStamp.toDate()));
                secondsFormat = int.parse(seconds.format(timeStamp.toDate()));
                var timeFormat = DateFormat('a').format(timeStamp.toDate());

                var defrenceTime = DateTime(
                        yearFormat,
                        monthFormat,
                        dayFormat,
                        timeFormat == 'AM' ? hourFormat : hourFormat + 12,
                        minuteFormat,
                        secondsFormat)
                    .difference(DateTime.now())
                    .inSeconds;
                print('${defrenceTime} oooooooooooooooooo');

                var date = DateFormat('d/MM/y').format(timeStamp.toDate());

                var timing = DateFormat.jm().format(timeStamp.toDate());

                final webinar = WebinarCardDb(
                  topic: courseName,
                  webinarType: payment,
                  mentorDesignation: designation,
                  mentorName: trainerName,
                  mentorImage: trainerImage,
                  date: date.toString(),
                  time: timing.toString(),
                  onPressed: () {
                    print(payment);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MobileSingleWebinarScreen(
                                  topic: courseName,
                                )));
                  },
                );
                if (defrenceTime > 0) {
                  timingList.add(defrenceTime);
                  timingList.sort();

                  courseMap.addAll({defrenceTime: webinar});
                }
              }
              print(timingList);
              for (var i in timingList) {
                print(i);

                courseList.add(courseMap[i]);
              }

              return Wrap(
                alignment: WrapAlignment.center,
                children: courseList,
              );
            }
          },
        ),
      ),
    );
  }
}

class WebinarCardDb extends StatefulWidget {
  WebinarCardDb(
      {this.time,
      this.date,
      this.topic,
      this.mentorDesignation,
      this.mentorName,
      this.mentorImage,
      this.webinarType,
      this.onPressed});
  String mentorName;
  Function onPressed;
  String mentorDesignation;
  String time;
  String date;
  String webinarType;
  String topic;
  String mentorImage;
  @override
  _WebinarCardDbState createState() => _WebinarCardDbState();
}

bool istest = false;

class _WebinarCardDbState extends State<WebinarCardDb> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 400,
    width: 300,
    color: ,);
  }
}


//
// Container(
// width: 300,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// color: Color(0xFF111111),
// ),
// margin: EdgeInsets.all(30),
// padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
// child: Row(
// children: [
// Container(
// width: 250,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// widget.topic,
// style: TextStyle(
// color: Color(0xFF36BAFF),
// fontSize: 25,
// fontWeight: FontWeight.bold,
// fontFamily: "Gilroy"),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// children: [
// Text(
// "DATE :",
// style: TextStyle(
// color: Color(0xFFFFFFFF),
// fontSize: 15,
// fontWeight: FontWeight.normal,
// fontFamily: "Gilroy"),
// ),
// SizedBox(
// width: 10,
// ),
// Text(
// widget.date,
// style: TextStyle(
// color: Color(0xFF36BAFF),
// fontSize: 15,
// fontWeight: FontWeight.normal,
// fontFamily: "Gilroy"),
// ),
// ],
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// children: [
// Text(
// "TIME :",
// style: TextStyle(
// color: Color(0xFFFFFFFF),
// fontSize: 15,
// fontWeight: FontWeight.normal,
// fontFamily: "Gilroy"),
// ),
// SizedBox(
// width: 10,
// ),
// Text(
// widget.time,
// style: TextStyle(
// color: Color(0xFF36BAFF),
// fontSize: 15,
// fontWeight: FontWeight.normal,
// fontFamily: "Gilroy"),
// ),
// ],
// ),
// SizedBox(
// height: 20,
// ),
// Text(
// widget.webinarType,
// style: TextStyle(
// color: Color(0xFFFFFFFF),
// fontSize: 20,
// fontWeight: FontWeight.normal,
// fontFamily: "Gilroy"),
// ),
// Container(
// width: 200,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Image.network(
// widget.mentorImage,
// width: 300,
// ),
// SizedBox(
// height: 20,
// ),
// Text(
// widget.mentorName,
// style: TextStyle(
// color: Color(0xFFFFFFFF),
// fontSize: 15,
// fontWeight: FontWeight.bold,
// fontFamily: "Gilroy"),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// widget.mentorDesignation,
// style: TextStyle(
// color: Color(0xFFFFFFFF),
// fontSize: 15,
// fontWeight: FontWeight.normal,
// fontFamily: "Gilroy"),
// ),
// ],
// ),
// ),
// SizedBox(
// height: 10,
// ),
// ButtonTheme(
// minWidth: 250,
// height: 50,
// child: RaisedButton(
// child: Text(
// "REGISTER NOW",
// style: TextStyle(
// color: Color(0xFFFFFFFF),
// fontSize: 20,
// fontWeight: FontWeight.bold,
// fontFamily: "Gilroy"),
// ),
// color: Color(0xFF36BAFF),
// onPressed: widget.onPressed),
// ),
// ],
// ),
// ),
// ],
// ),
// );