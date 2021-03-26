import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/screen/career/career_lg.dart';
import 'package:ocean_project/desktopview/screen/career/career_md.dart';
import 'package:ocean_project/desktopview/screen/career/career_sm.dart';

class CareerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1600) {
        return Career_lg();
      } else if (constraints.maxWidth > 1300 && constraints.maxWidth < 1600) {
        return Career_md();
      } else if (constraints.maxWidth > 600 && constraints.maxWidth < 1300) {
        return Career_sm();
      }
    });
  }
}
