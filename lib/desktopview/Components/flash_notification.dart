import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/webinar/wbinar_menubar.dart';
import 'package:ocean_project/webinar/single_wbinar.dart';
import 'package:ocean_project/webinar/upcoming_webinar.dart';
import 'package:ocean_project/webinar/webinar_live.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class FlashNotification extends StatefulWidget {
  FlashNotification(
      {this.joinButton,
      this.dismissNotification,
      this.joinButtonName,
      this.webinar,
      this.upcomingButton});
  Function upcomingButton;
  Function joinButton;
  Function dismissNotification;
  String joinButtonName = 'JOIN';
  Map webinar;

  @override
  _FlashNotificationState createState() => _FlashNotificationState();
}

class _FlashNotificationState extends State<FlashNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('@@@@@@@@@@@@@@@@@@@@@@@@');
    print(widget.webinar);

    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Webinar').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<FlashDb> courseList = [];
                    List<int> timingList = [];
                    Map<int, Widget> courseMap = {};
                    List<Widget> currentWebinar = [];

                    for (var message in messages) {
                      Timestamp time = message.data()['timestamp'];
                      final freeWebinarContent = message.data()['course'];
                      final payment = message.data()['payment'];

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

                      yearFormat = int.parse(year.format(time.toDate()));
                      monthFormat = int.parse(month.format(time.toDate()));
                      dayFormat = int.parse(day.format(time.toDate()));
                      hourFormat = int.parse(hour.format(time.toDate()));
                      minuteFormat = int.parse(minute.format(time.toDate()));
                      secondsFormat = int.parse(seconds.format(time.toDate()));

                      var defrenceTime = DateTime(
                              yearFormat,
                              monthFormat,
                              dayFormat,
                              hourFormat,
                              minuteFormat,
                              secondsFormat)
                          .difference(DateTime.now())
                          .inSeconds;

                      if (defrenceTime > 0) {
                        final webinar = FlashDb(
                          content: freeWebinarContent,
                          joinButton: widget.joinButton,
                          dismissNotification: widget.dismissNotification,
                          payment: payment,
                          wbinarLive: currentWebinar,
                        );
                        timingList.add(defrenceTime);
                        timingList.sort();

                        courseMap.addAll({defrenceTime: webinar});
                      } else {
                        final webinar = FlashDb(
                          content: freeWebinarContent,
                          joinButton: widget.joinButton,
                          dismissNotification: widget.dismissNotification,
                          payment: payment,
                          wbinarLive: currentWebinar,
                        );
                        currentWebinar.add(webinar);
                      }
                    }
                    for (var i in timingList) {
                      courseList.add(courseMap[i]);
                    }
                    return Container(
                      child: Column(
                        children: [
                          currentWebinar.isEmpty
                              ? courseList[0]
                              : currentWebinar[0]
                        ],
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: kfontname),
                  ),
                  height: 40,
                  color: Colors.white,
                  onPressed: () {
                    Provider.of<Routing>(context, listen: false)
                        .updateRouting(widget: UpcomingWebinar());
                    Provider.of<MenuBar>(context, listen: false)
                        .updateMenu(widget: WebinarMenu());
                  },
                ),
              ),
            ],
          ),
          IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () {
                setState(() {
                  Navbar.isNotification = false;
                });
              }),
        ],
      ),
    );
  }
}

class FlashDb extends StatefulWidget {
  Function joinButton;
  Function upcomingButton;
  Function dismissNotification;
  String joinButtonName = 'JOIN';
  List<Widget> wbinarLive;
  String content;
  String payment;
  FlashDb(
      {this.content,
      this.joinButton,
      this.dismissNotification,
      this.joinButtonName,
      this.payment,
      this.upcomingButton,
      this.wbinarLive});

  @override
  _FlashDbState createState() => _FlashDbState();
}

class _FlashDbState extends State<FlashDb> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 20),
                children: [
              TextSpan(text: widget.content),
              TextSpan(
                  text: ' Value based webinar ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'Now'),
            ])),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: FlatButton(
            child: Text(
              "Join",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: kfontname),
            ),
            height: 40,
            color: Colors.white,
            onPressed: () {
              setState(() {
                Navbar.isNotification = false;
              });
              Provider.of<Routing>(context, listen: false).updateRouting(
                  widget: widget.wbinarLive.isEmpty
                      ? SingleWebinarScreen(
                          topic: widget.content,
                        )
                      : LiveWebinar());
              Provider.of<MenuBar>(context, listen: false)
                  .updateMenu(widget: WebinarMenu());
            },
          ),
        ),
      ],
    );
  }
}
