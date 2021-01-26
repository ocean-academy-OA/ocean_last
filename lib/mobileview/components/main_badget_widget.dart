import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/mobileview/components/badge_widget.dart';

import 'main_title_widget.dart';

class MainBadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainTitleWidget(
        title: "Our journey through the years",
      ),
      Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "5500+ Students trained",
                title: '5500+ Students trained',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "50+ Free seminars",
                title: '50+ Free seminars',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "6 International workshops",
                title: '6 International workshops',
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
