import 'package:flutter/material.dart';

class LoginLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1600) {
        return null;
      } else if (constraints.maxWidth > 1300 && constraints.maxWidth < 1600) {
        return null;
      }
    });
  }
}
