import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

class MenuFlatButton extends StatelessWidget {
  final String title;
  MenuFlatButton({@required this.title});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        title,
        style: menuTextStyle,
      ),
      onPressed: () {},
    );
  }
}
