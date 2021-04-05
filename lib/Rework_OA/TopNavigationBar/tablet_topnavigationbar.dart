import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';

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
          height: 220,
          width: double.infinity,
          child: Center(
            child: AutoSizeText(
              title,
              maxLines: 1,
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                wordSpacing: 1.8,
                fontFamily: kfontname,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Icon(
            Ocean.o,
            size: 50,
            color: Color(0xffBFD400),
          ),
        ),
        Positioned(
          top: 90,
          left: 60,
          child: Icon(
            Ocean.o,
            size: 50,
            color: Color(0xffF8BE5A),
          ),
        ),
        Positioned(
          top: 140,
          left: 120,
          child: Icon(
            Ocean.line_circleshape,
            size: 60,
            color: Color(0xffFFD444),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Icon(
            Ocean.o,
            size: 50,
            color: Color(0xffBFD400),
          ),
        ),
        Positioned(
          top: 100,
          right: 70,
          child: Icon(
            Ocean.o,
            size: 50,
            color: Color(0xffF8BE5A),
          ),
        ),
        Positioned(
          top: 85,
          right: -3,
          child: Transform.rotate(
            angle: -0.4,
            child: Icon(
              Ocean.a,
              size: 55,
              color: Color(0xff00FFB9),
            ),
          ),
        ),
        Positioned(
          top: 160,
          right: 30,
          child: Transform.rotate(
            angle: -0.4,
            child: Icon(
              Ocean.a,
              size: 60,
              color: Color(0xffFF00FF),
            ),
          ),
        ),
        Positioned(
          top: 140,
          right: 140,
          child: Icon(
            Ocean.line_circleshape,
            size: 60,
            color: Color(0xffFFD444),
          ),
        )
      ],
    );
  }
}
