import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/webinar/countdown.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Webinar extends StatefulWidget {
  @override
  _WebinarState createState() => _WebinarState();
}

// timerFunction() async {
//   var timeing =
//       await _firestore.collection('webinar').doc('free_webinar').get();
//   return Timer(
//     cDay: timeing.data()['day'],
//     cHours: timeing.data()['hour'],
//     cMinute: timeing.data()['minute'],
//     cMonth: timeing.data()['month'],
//   );
// }

class _WebinarState extends State<Webinar> {
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
          color: Colors.red,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  width: 1200,
                  height: 580,
                ),
              ),
              Positioned(
                  right: 0,
                  top: 13,
                  child: Image(
                    image: NetworkImage('images/webinar/notebook.svg'),
                    height: 680,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
