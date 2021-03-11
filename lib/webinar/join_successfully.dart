import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/upcoming_course_widget.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'package:ocean_project/webinar/upcoming_webinar.dart';
import 'package:provider/provider.dart';

class JoinSuccessfully extends StatefulWidget {
  @override
  _JoinSuccessfullyState createState() => _JoinSuccessfullyState();
}

class _JoinSuccessfullyState extends State<JoinSuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Color(0xff0D6BA1),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(),
              Container(
                child: Column(
                  children: [
                    Text(
                      'OCEAN ACADEMY',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: kfontname,
                          color: Colors.white),
                    ),
                    Text(
                      'Digital technology',
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: kfontname,
                          color: Colors.blue[200]),
                    )
                  ],
                ),
              ),
              SizedBox(),
              SizedBox(),
              FlatButton(
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.white,
                onPressed: () {
                  print('login clicked');
                },
              ),
              SizedBox(),
            ],
          )
        ],
      ),
    ));
  }
}
