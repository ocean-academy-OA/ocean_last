import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatefulWidget {
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
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
                  Row(
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
                        "OCEAN ACADEMY",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                    ],
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
                            Provider.of<Routing>(context, listen: false)
                                .updateRouting(widget: CoursesView());
                            setState(() {
                              CourseContent.isShow = !CourseContent.isShow;
                            });
                          },
                          child: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.white,
                            size: 50.0,
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
                            Provider.of<Routing>(context, listen: false)
                                .updateRouting(widget: CoursesView());
                            setState(() {
                              CourseContent.isVisible =
                                  !CourseContent.isVisible;
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
          visible: CourseContent.isVisible,
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
          visible: CourseContent.isShow,
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
