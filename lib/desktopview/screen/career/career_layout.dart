import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_project/desktopview/screen/career/career_lg.dart';
import 'package:ocean_project/desktopview/screen/career/career_md.dart';
import 'package:ocean_project/desktopview/screen/career/career_sm.dart';

class CareerLayout extends StatelessWidget {
  static final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1600) {
        return CareerLg();
      } else if (constraints.maxWidth > 1300 && constraints.maxWidth < 1601) {
        return CareerMd();
      } else if (constraints.maxWidth > 600 && constraints.maxWidth < 1301) {
        return CareerSm();
      }
    });
  }
}
