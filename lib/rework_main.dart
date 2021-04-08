import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/Rework_OA/AboutUs/desktop_aboutus.dart';
import 'package:ocean_project/Rework_OA/AboutUs/tablet_aboutus.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: TabletAboutUs()),
    ),
  );
}
