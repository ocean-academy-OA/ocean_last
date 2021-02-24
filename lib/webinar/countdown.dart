import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:timer_count_down/timer_count_down.dart';

const Color kBlue = Color(0xff36BAFF);
FirebaseFirestore _firestore = FirebaseFirestore.instance;

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: Timer(),
//     ),
//   ));
// }

class Timer extends StatefulWidget {
  int cMonth = 0;
  int cHours = 2;
  int cMinute = 0;
  int cDay = 0;

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  Duration _duration = Duration(days: 10, hours: 2, minutes: 2, seconds: 0);
  bool timeUp = false;

  // int cMonth = int.parse(DateFormat('M').format(DateTime.now()));
  // int cHours = int.parse(DateFormat('h').format(DateTime.now()));
  // int cMinute = int.parse(DateFormat('m').format(DateTime.now()));
  // int cDay = int.parse(DateFormat('d').format(DateTime.now()));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 110,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: kBlue, width: 3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SlideCountdownClock(
                          duration: Duration(
                              days: widget.cDay,
                              hours: widget.cHours,
                              minutes: widget.cMinute),
                          separator: ' : ',
                          textStyle: TextStyle(
                              fontSize: 40,
                              fontFamily: kfontname,
                              color: kBlue),
                          separatorTextStyle:
                              TextStyle(fontSize: 35, color: kBlue),
                          shouldShowDays: true,
                          onDone: () {
                            setState(() {
                              timeUp = true;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 5),
                            Text(
                              'DAYS',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                            SizedBox(width: 1),
                            Text(
                              'HRS',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                            SizedBox(width: 1),
                            Text(
                              'MIN',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                            SizedBox(width: 1),
                            Text(
                              'SEC',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: kfontname,
                                  color: kBlue),
                            ),
                            SizedBox(width: 5)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: Text(
                        'Webinar nds in...',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: FlatButton(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: kBlue,
                minWidth: double.infinity,
                height: 60,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
