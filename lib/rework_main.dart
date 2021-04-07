import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/Rework_OA/AboutUs/desktop_aboutus.dart';
import 'package:ocean_project/Rework_OA/AboutUs/mobile_aboutus.dart';
import 'package:ocean_project/Rework_OA/Footer/desktop_footer.dart';
import 'package:ocean_project/Rework_OA/TopNavigationBar/tablet_topnavigationbar.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: TabletTopNavigationBar()),
    ),
  );
}
