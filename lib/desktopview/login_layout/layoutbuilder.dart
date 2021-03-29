import 'package:flutter/cupertino.dart';
import 'package:ocean_project/desktopview/login_layout/login_lg.dart';
import 'package:ocean_project/desktopview/login_layout/login_md.dart';
import 'package:ocean_project/desktopview/login_layout/login_sm.dart';
import 'package:ocean_project/desktopview/login_layout/login_xs.dart';

class LoginLayout extends StatelessWidget {
  static TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1600) {
        return LoginLG();
      } else if (constraints.maxWidth > 1300 && constraints.maxWidth < 1600) {
        return LoginMD();
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1300) {
        return LoginSM();
      } else {
        return LoginXS();
      }
    });
  }
}
