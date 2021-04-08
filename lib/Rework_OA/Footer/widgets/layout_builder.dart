import 'package:flutter/material.dart';
import 'package:ocean_project/Rework_OA/Footer/desktop_footer_lg.dart';
import 'package:ocean_project/Rework_OA/Footer/desktop_footer_md.dart';

class DesktopFooterLayout extends StatelessWidget {
  static final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1400) {
        return DesktopFooterLg();
      } else if (constraints.maxWidth > 950 && constraints.maxWidth < 1401) {
        return DesktopFooterMd();
      }
    });
  }
}
