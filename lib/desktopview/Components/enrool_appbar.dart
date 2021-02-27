import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/enroll_new.dart';
import 'package:ocean_project/desktopview/Components/main_notification.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'package:provider/provider.dart';

final _firestore = FirebaseFirestore.instance;

class AppBarWidget extends StatefulWidget {
  AppBarWidget({this.userProfile});
  String userProfile;
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  String userProfile;
  getProfilePicture() async {
    var details = await _firestore
        .collection('new users')
        .doc(OALive.stayUser != null ? OALive.stayUser : LogIn.registerNumber)
        .get(); // 8015122373 insted of  LogIn.userNum
    userProfile = details.data()['Profile Picture'];
  }

  getImage() async {
    StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('new users').snapshots(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading.....");
          } else {
            final messages = snapshot.data.docs;
            for (var message in messages) {
              // ignore: unrelated_type_equality_checks
              if (OALive.stayUser == message.data() ||
                  // ignore: unrelated_type_equality_checks
                  LogIn.registerNumber == message.data()) {
                final dbImage = message.data()['Profile Picture'];
                userProfile = dbImage;
              }
            }
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    getImage();
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              height: 100.0,
              color: Color(0xff0091D2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<Routing>(context, listen: false)
                          .updateRouting(widget: Home());
                      Provider.of<OALive>(context, listen: false)
                          .updateOA(routing: Navbar());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Ocean.oa,
                          size: 70.0,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "ocean academy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 35),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    width: 500.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: Color(0xFF0091D2),
                                size: 30.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "My Classroom",
                                style: TextStyle(
                                  color: Color(0xFF0091D2),
                                  fontSize: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(10.0),
                          minWidth: 10.0,
                          hoverColor: Colors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(600.0))),
                          onPressed: () {
                            setState(() {
                              Provider.of<OALive>(context, listen: false)
                                  .updateOA(routing: CoursesView());
                              ContentWidget.isShow = !ContentWidget.isShow;
                            });
                          },
                          child: userProfile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100.0),
                                  child: Image.network(userProfile,
                                      height: 60, width: 60, fit: BoxFit.cover),
                                )
                              : Icon(
                                  FontAwesomeIcons.solidUserCircle,
                                  size: 60,
                                  color: Colors.white,
                                ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(10.0),
                          minWidth: 10.0,
                          hoverColor: Colors.white10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(600.0))),
                          onPressed: () {
                            setState(() {
                              Provider.of<OALive>(context, listen: false)
                                  .updateOA(routing: CoursesView());
                              ContentWidget.isVisible =
                                  !ContentWidget.isVisible;
                            });
                          },
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                            size: 50.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: ContentWidget.isVisible,
          child: Positioned(
            top: 90,
            right: 63,
            // right: 23,
            child: ClipPath(
              clipper: TraingleClipPath(),
              child: Container(
                height: 10,
                width: 10,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Visibility(
          visible: ContentWidget.isShow,
          child: Positioned(
            top: 90,
            right: 176,
            // right: 23,
            child: ClipPath(
              clipper: TraingleClipPath(),
              child: Container(
                height: 10,
                width: 10,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
    //   ],
    // );
  }

  Image profileImage() {
    return Image.network(widget.userProfile,
        height: 60, width: 60, fit: BoxFit.cover);
  }
}

class TraingleClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(5, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(5, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
