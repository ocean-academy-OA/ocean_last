import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/Components/flash_notification.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';

import 'package:ocean_project/desktopview/screen/services.dart';
import 'package:ocean_project/webinar/countdown.dart';
import 'package:ocean_project/webinar/get_date.dart';
import 'package:ocean_project/webinar/webinar.dart';
import 'package:ocean_project/webinar/webinar_page.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'about_us_screen.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Navbar extends StatefulWidget {
  static bool visiblity = true;
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
    'Career': false,
  };
  bool isNotification = true;
  // getDateFromDb() async {
  //   var timeing =
  //       await _firestore.collection('webinar').doc('free_webinar').get();
  //   widget.cDay = timeing.data()['day'];
  //   widget.cHours = timeing.data()['hour'];
  //   widget.cMinute = timeing.data()['minute'];
  //   widget.cMonth = timeing.data()['month'];
  // }

  _datepicker(BuildContext context) async {
    var selectDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2022));
    print(selectDate);
  }

  Timestamp timestamp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Visibility(
            visible: isNotification,
            child: FlashNotification(
              dismissNotification: () {
                setState(() {
                  isNotification = false;
                });
              },
              joinButton: () async {
                await for (var snapshot in _firestore
                    .collection('webinar_time')
                    .snapshots(includeMetadataChanges: true)) {
                  for (var message in snapshot.docs) {
                    timestamp = message.data()['timeStamp'];
                  }
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebinarScreen(
                              timestamp: timestamp,
                            )));
              },
              joinButtonName: 'Join Now',
            ),
          ),
          Visibility(
            visible: Navbar.visiblity,
            child: Container(
              color: Color(0xFFECF5FF),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: Home());
                      },
                      child: Row(
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
                        menuItem(text: 'Career', widget: Home()),
                        SizedBox(
                          width: 60.0,
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(20.0),
                          minWidth: 150.0,
                          color: Color(0xFF0091D2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          onPressed: () {
                            print('${OALive.stayUser} Stay user');
                            // if (Routing.stayUser != null) {
                            //   setState(() {
                            //     // print("${Navbar.visiblity}vvvvvvvvvvvvvvvvv");
                            //     // Navbar.visiblity = false;
                            //   });
                            //
                            //   ///todo:instead of resiter login will come
                            //   Provider.of<Routing>(context, listen: false)
                            //       .updateRouting(
                            //           widget: CoursesView(
                            //     userID: Routing.stayUser,
                            //   ));
                            // } else {
                            //   setState(() {
                            //     // print("${Navbar.visiblity}vvvvvvvvvvvvvvvvv");
                            //     // Navbar.visiblity = true;
                            //   });

                            ///todo:instead of resiter login will come
                            Provider.of<Routing>(context, listen: false)
                                .updateRouting(widget: LogIn());
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Gilroy"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              //
            ),
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
              fontFamily: "Gilroy"),
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
