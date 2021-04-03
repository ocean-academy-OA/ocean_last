import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/Rework_OA/AboutUs/mobile_aboutus.dart';
import 'package:ocean_project/Rework_OA/AboutUs/tablet_aboutus.dart';
import 'Rework_OA/AboutUs/desktop_aboutus.dart';
import 'Rework_OA/ContactUs/desktop_contactus.dart';
import 'package:ocean_project/Rework_OA/ContactUs/tablet_contactus.dart';
import 'package:ocean_project/Rework_OA/career/career_layout.dart';
import 'package:ocean_project/Rework_OA/Footer/desktop_footer.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: DesktopFooter()),
    ),
  );
}
