import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/login_button.dart';

import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:ocean_project/desktopview/screen/services.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'about_us_screen.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Map menu = {
    'Home': true,
    'About Us': false,
    'Services': false,
    'Course': false,
    'Contact Us': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            color: Color(0xFFECF5FF),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Ocean.oa,
                        size: 50.0,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "ocean academy",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0091D2),
                            fontSize: 30),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menuItem(text: 'Home', widget: Home()),
                      SizedBox(
                        width: 60.0,
                      ),
                      menuItem(text: 'About Us', widget: AboutUs()),
                      SizedBox(
                        width: 60.0,
                      ),
                      menuItem(text: 'Services', widget: Service()),
                      SizedBox(
                        width: 60.0,
                      ),
                      menuItem(text: 'Course', widget: Course()),
                      SizedBox(
                        width: 60.0,
                      ),
                      menuItem(text: 'Contact Us', widget: ContactUs()),
                      SizedBox(
                        width: 60.0,
                      ),
                      LogInButton()
                    ],
                  ),
                ],
              ),
            ),
            //
          ),
          Expanded(
            child: Consumer<Routing>(
              builder: (context, routing, child) {
                return routing.route;
              },
            ),
          ),
        ],
      ),
    );
  }

  MouseRegion menuItem({text, widget}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(
              color: menu[text] ? Colors.blue : Color(0xFF155575),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Open Sans"
                  ""),
        ),
        onTap: () {
          setState(() {
            //contentWidget = widget
            menu.updateAll((key, value) => menu[key] = false);
            menu[text] = true;
          });
          Provider.of<Routing>(context, listen: false)
              .updateRouting(widget: widget);
        },
      ),
    );
  }
}
