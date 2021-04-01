import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/enrool_appbar.dart';
import 'package:ocean_project/desktopview/Components/flash_notification.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/new_user_screen/otp.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/career/career_layout.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:ocean_project/desktopview/screen/services.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'about_us_screen.dart';
import 'package:ocean_project/desktopview/login_layout/layoutbuilder.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Navbar extends StatefulWidget {
  static bool visiblity = true;
  static bool isNotification = true;

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Timestamp timestamp;
  void retriveTime() async {
    await for (var snapshot in _firestore
        .collection('webinar')
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        timestamp = message.data()['timeStamp'];
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retriveTime();
    //session();
  }

  // session() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('login', 1);
  //   await prefs.setString('user', MenuBar.stayUser);
  //   print("${MenuBar.stayUser}dddddddddddddddddddddddddddddddddddddd");
  //   MenuBar.stayUser = LogIn.registerNumber;
  //
  //   //getProfilePicture();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Webinar').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.docs.isNotEmpty) {
                    return Visibility(
                      visible: Navbar.isNotification,
                      child: FlashNotification(
                        dismissNotification: () {
                          setState(() {
                            Navbar.isNotification = false;
                          });
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                } else {
                  return SizedBox();
                }
              }),
          Consumer<MenuBar>(
            builder: (context, routing, child) {
              return routing.route;
            },
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
}

class NavbarRouting extends StatefulWidget {
  static Map menu = {
    'Home': true,
    'About Us': false,
    'Services': false,
    'Course': false,
    'Contact Us': false,
    'Career': false,
  };

  @override
  _NavbarRoutingState createState() => _NavbarRoutingState();
}

class _NavbarRoutingState extends State<NavbarRouting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String valueChoose;

  List<String> courseList = [
    'Online',
    'Offline',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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

                ///todo dropdown button to remove the hide
                // menuItem(text: 'Course', widget: Course()),
                // Column(
                //   children: [
                //     DropdownButton(
                //       hint: Text(
                //         "Courses",
                //         style: TextStyle(
                //             fontSize: 20.0,
                //             fontWeight: FontWeight.bold,
                //             fontFamily: "Gilroy"),
                //       ),
                //       onChanged: (newValue) {
                //         valueChoose = newValue;
                //         print(valueChoose);
                //         valueChoose == "Online"
                //             ? Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => OnlineCourseNew()))
                //             : Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) => OfflineCourseNew()));
                //       },
                //       items: [
                //         DropdownMenuItem(
                //           child: Text("Online"),
                //           value: "Online",
                //         ),
                //         DropdownMenuItem(
                //           child: Text("Offline"),
                //           value: "Offline",
                //         )
                //       ],
                //     ),
                //   ],
                // ),

                SizedBox(
                  width: 60.0,
                ),
                menuItem(text: 'Contact Us', widget: ContactUs()),
                SizedBox(
                  width: 60.0,
                ),
                menuItem(text: 'Career', widget: CareerLayout()),
                SizedBox(
                  width: 60.0,
                ),
                MaterialButton(
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Gilroy"),
                  ),
                  padding: EdgeInsets.all(20.0),
                  minWidth: 150.0,
                  color: Color(0xFF0091D2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  onPressed: () {
                    print('${MenuBar.stayUser}MenuBar.stayUser');
                    print("${LogIn.registerNumber}LogIn.registerNumber");
                    print("${OTP.userID}OTP.userID");

                    setState(() {
                      NavbarRouting.menu.updateAll(
                          (key, value) => NavbarRouting.menu[key] = false);
                    });

                    ///todo:instead of resiter login will come
                    ///
                    Provider.of<Routing>(context, listen: false).updateRouting(
                        widget:
                            MenuBar.stayUser == null ? LogIn() : CoursesView());
                    Provider.of<MenuBar>(context, listen: false).updateMenu(
                        widget: MenuBar.stayUser == null
                            ? NavbarRouting()
                            : AppBarWidget());
                  },
                )
              ],
            ),
          ],
        ),
      ),
      //
    );
  }

  MouseRegion menuItem({text, widget}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(
              color: NavbarRouting.menu[text] ? Colors.blue : Color(0xFF155575),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Gilroy"),
        ),
        onTap: () {
          setState(() {
            NavbarRouting.menu
                .updateAll((key, value) => NavbarRouting.menu[key] = false);
            NavbarRouting.menu[text] = true;
          });
          Provider.of<Routing>(context, listen: false)
              .updateRouting(widget: widget);
          Provider.of<MenuBar>(context, listen: false)
              .updateMenu(widget: NavbarRouting());
          print(text);
        },
      ),
    );
  }
}
