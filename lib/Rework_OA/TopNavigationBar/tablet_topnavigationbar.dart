import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/Rework_OA/Widgets/ocean_icons.dart';

import 'package:ocean_project/desktopview/constants.dart';

class TabletTopNavigationBar extends StatelessWidget {
  final String title;

  TabletTopNavigationBar({this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xff0091D2),
          height: 180,
          width: double.infinity,
          child: Center(
            child: AutoSizeText(
              "title",
              maxLines: 1,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                wordSpacing: 1.8,
                fontFamily: kfontname,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          top: 15,
          left: 15,
          child: Icon(
            Ocean.o,
            size: 45,
            color: Color(0xffBFD400),
          ),
        ),
        Positioned(
          top: 75,
          left: 50,
          child: Icon(
            Ocean.o,
            size: 45,
            color: Color(0xffF8BE5A),
          ),
        ),
        Positioned(
          top: 120,
          left: 110,
          child: Icon(
            Ocean.line_circleshape,
            size: 50,
            color: Color(0xffFFD444),
          ),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: Icon(
            Ocean.o,
            size: 40,
            color: Color(0xffBFD400),
          ),
        ),
        Positioned(
          top: 80,
          right: 60,
          child: Icon(
            Ocean.o,
            size: 40,
            color: Color(0xffF8BE5A),
          ),
        ),
        Positioned(
          top: 70,
          right: -3,
          child: Transform.rotate(
            angle: -0.4,
            child: Icon(
              Ocean.a,
              size: 40,
              color: Color(0xff00FFB9),
            ),
          ),
        ),
        Positioned(
          top: 130,
          right: 35,
          child: Transform.rotate(
            angle: -0.4,
            child: Icon(
              Ocean.a,
              size: 40,
              color: Color(0xffFF00FF),
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: 110,
          child: Icon(
            Ocean.line_circleshape,
            size: 50,
            color: Color(0xffFFD444),
          ),
        )
      ],
    );
  }
}
