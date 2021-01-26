import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

import 'badge_widget.dart';
import 'main_title_widget.dart';

class MainBadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF7F7F7),
      child: Column(children: [
        SizedBox(
          height: 30.0,
        ),
        MainTitleWidget(
          title: "Our journey through the years",
        ),
        SizedBox(
          height: 50.0,
        ),
        Container(
          child: Row(
            children: [
              Expanded(
                child: BadgeWidget(
                  icon: Icons.account_balance,
                  heading: "5500+ Students trained",
                  title: "5500+ Students trained",
                ),
              ),
              Expanded(
                child: BadgeWidget(
                  icon: Icons.account_balance,
                  heading: "50+ Free seminars",
                  title: "50+ Free seminars",
                ),
              ),
              Expanded(
                child: BadgeWidget(
                  icon: Icons.account_balance,
                  heading: "6 International workshops",
                  title: "6 International workshops",
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        )
      ]),
    );
  }
}
