import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/main.dart';
import 'package:ocean_project/mobileview/main.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      debugShowCheckedModeBanner: false,
      home: ScreenTypeLayout(),
    ),
  );
}

class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget mobile = OceanMobileView();
  final Widget tablet = OceanMobileView();
  final Widget desktop = OceanLive();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      // if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
      //   if (tablet != null) {
      //     return tablet;
      //   }
      // }

      // If sizing indicates desktop and we have a desktop widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        print("desktop");

        if (desktop != null) {
          print("desktop");
          return OceanLive();
        }
      }

      // Return mobile layout if nothing else is supplied
      return OceanMobileView();
    });
  }
}
