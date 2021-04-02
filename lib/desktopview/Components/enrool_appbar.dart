import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/certificates.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/enroll_new.dart';
import 'package:ocean_project/desktopview/Components/my_course.dart';
import 'package:ocean_project/desktopview/Components/main_notification.dart';
import 'package:ocean_project/desktopview/Components/notification.dart';
import 'package:ocean_project/desktopview/Components/purchase.dart';
import 'package:ocean_project/desktopview/Components/user_profile.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';
import 'package:ocean_project/desktopview/new_user_screen/edit_profile.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/new_user_screen/otp.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'package:ocean_project/pop_up_menu_botton_custamize.dart';
import 'package:ocean_project/popupMenu.dart';

import 'package:shared_preferences/shared_preferences.dart';
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
  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    await prefs.setString('user', MenuBar.stayUser);
    print("${MenuBar.stayUser} MenuBar.stayUser");
    MenuBar.stayUser = OTP.userID;

    //getProfilePicture();
  }

  notification() async {
    var db = await _firestore.collection('new users').get();
    var notify = db.docs;
    for (var title in notify) {
      print(title.data()['First Name']);
      FocusedMenuItem item = FocusedMenuItem(
          title: Text(
            title.data()['First Name'],
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            print(title.data()['First Name']);
          },
          backgroundColor: Colors.grey[700]);
      notificationItem.add(item);
      if (notificationItem.length == 4) {
        break;
      }
    }
    notificationItem.add(FocusedMenuItem(
        title: Text(
          'See All',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Provider.of<Routing>(context, listen: false)
              .updateRouting(widget: User());
          Provider.of<MenuBar>(context, listen: false)
              .updateMenu(widget: AppBarWidget());
        }));
  }

  List<FocusedMenuItem> notificationItem = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    session();
    print('hhhhhhhhhhhhhhhhhhhhhhhhhh');
    notification();

    //getImage();
  }

  GlobalKey notificationKey = GlobalKey();
  void onClickMenu(MenuItemProvider item) async {
    print('selected menu -> ${item.menuTitle}');
    Provider.of<Routing>(context, listen: false)
        .updateRouting(widget: CoursesView());
    Provider.of<UserProfiles>(context, listen: false)
        .updateUser(routing: Notification_onclick());
  }

  void popupMenuButton() {
    PopupMenu menu = PopupMenu(
      maxColumn: 1,
      incrementWidth: 100,
      backgroundColor: Colors.grey[700],
      lineColor: Colors.blue,
      shadow: false,
      onClickMenu: onClickMenu,
      // highlightColor: Colors.red,
      items: [
        MenuItem(
            title: 'See all Notification',
            textStyle: TextStyle(fontSize: 15, color: Colors.white)),
      ],
    );
    menu.show(widgetKey: notificationKey);
  }

  String test;
  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    session();
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
                      Provider.of<MenuBar>(context, listen: false)
                          .updateMenu(widget: NavbarRouting());
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
                    width: 830.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          onPressed: () {
                            Provider.of<Routing>(context, listen: false)
                                .updateRouting(widget: CoursesView());
                            Provider.of<SyllabusView>(context, listen: false)
                                .updateCourseSyllabus(routing: MyCourse());
                            Provider.of<MenuBar>(context, listen: false)
                                .updateMenu(widget: AppBarWidget());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.menu_book,
                                color: Color(0xFF0091D2),
                                size: 30.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "My Courses",
                                style: TextStyle(
                                  color: Color(0xFF0091D2),
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(20.0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          onPressed: () {
                            Provider.of<Routing>(context, listen: false)
                                .updateRouting(widget: CoursesView());
                            Provider.of<SyllabusView>(context, listen: false)
                                .updateCourseSyllabus(routing: EnrollNew());
                            Provider.of<MenuBar>(context, listen: false)
                                .updateMenu(widget: AppBarWidget());
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.collections_bookmark_rounded,
                                color: Color(0xFF0091D2),
                                size: 30.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "All Courses",
                                style: TextStyle(
                                  color: Color(0xFF0091D2),
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream:
                              _firestore.collection('new users').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data.docs;
                              List<ProfilePictureDb> profile = [];

                              for (var message in messages) {
                                var id = MenuBar.stayUser != null
                                    ? MenuBar.stayUser
                                    : LogIn.registerNumber;
                                if (message.id == id) {
                                  final profileImage =
                                      message.data()['Profile Picture'];

                                  final pictures = ProfilePictureDb(
                                    profilePicture: profileImage,
                                    onpress: () {
                                      setState(() {
                                        ContentWidget.isShow =
                                            !ContentWidget.isShow;

                                        ContentWidget.isVisible = false;
                                      });
                                      Provider.of<Routing>(context,
                                              listen: false)
                                          .updateRouting(widget: CoursesView());

                                      Provider.of<UserProfiles>(context,
                                              listen: false)
                                          .updateUser(routing: User_Profile());
                                    },
                                  );
                                  profile.add(pictures);
                                }
                              }
                              return MaterialButton(
                                child: Row(
                                  children: profile,
                                ),
                              );
                            }
                          },
                        ),
                        FocusedMenuHolder(
                          openWithTap: true,
                          blurBackgroundColor: Colors.transparent,
                          animateMenuItems: false,
                          blurSize: 0,
                          animationDuration: 50,
                          arrowColor: Colors.grey[700],
                          menuWidth: 350,
                          onPressed: () {},
                          menuItemExtent: 55,
                          menuItems: notificationItem,
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                            size: 50.0,
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          minWidth: 10.0,
                          hoverColor: Colors.white10,
                          key: notificationKey,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(600.0))),
                          onPressed: true
                              ? popupMenuButton
                              : () {
                                  setState(() {
                                    ContentWidget.isVisible =
                                        !ContentWidget.isVisible;
                                    ContentWidget.isShow = false;
                                  });
                                  Provider.of<Routing>(context, listen: false)
                                      .updateRouting(widget: CoursesView());
                                  Provider.of<UserProfiles>(context,
                                          listen: false)
                                      .updateUser(
                                          routing: Notification_onclick());
                                },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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

class ProfilePictureDb extends StatefulWidget {
  String profilePicture;
  Function onpress;
  ProfilePictureDb({this.profilePicture, this.onpress});
  @override
  _ProfilePictureDbState createState() => _ProfilePictureDbState();
}

class _ProfilePictureDbState extends State<ProfilePictureDb> {
  GlobalKey menuButtonKey = GlobalKey();

  void onClickMenu(MenuItemProvider item) async {
    print('selected menu -> ${item.menuTitle}');
    if (item.menuTitle == 'Certificates') {
      Provider.of<Routing>(context, listen: false)
          .updateRouting(widget: Certificate());
      Provider.of<MenuBar>(context, listen: false)
          .updateMenu(widget: AppBarWidget());
    }
    if (item.menuTitle == 'My profile') {
      Provider.of<Routing>(context, listen: false)
          .updateRouting(widget: EditProfile());
      Provider.of<MenuBar>(context, listen: false)
          .updateMenu(widget: AppBarWidget());
    }
    if (item.menuTitle == 'Purchase') {
      Provider.of<Routing>(context, listen: false)
          .updateRouting(widget: Purchase());
      Provider.of<MenuBar>(context, listen: false)
          .updateMenu(widget: AppBarWidget());
    }
    if (item.menuTitle == 'Log Out') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setInt('login', 0);
      await prefs.setString('user', null);
      LogIn.registerNumber = null;
      OTP.userID = null;
      MenuBar.stayUser = null;
      Provider.of<Routing>(context, listen: false)
          .updateRouting(widget: Home());
      Provider.of<MenuBar>(context, listen: false)
          .updateMenu(widget: NavbarRouting());
    }
  }

  void popupMenuButton() {
    PopupMenu menu = PopupMenu(
      maxColumn: 1,
      incrementWidth: 80,
      incrementHeight: 50,
      backgroundColor: Colors.grey[700],
      lineColor: Colors.blue,
      shadow: false,
      onClickMenu: onClickMenu,
      // highlightColor: Colors.red,
      items: [
        MenuItem(
            title: 'Certificates',
            textStyle: TextStyle(fontSize: 15, color: Colors.white)),
        MenuItem(
            title: 'My profile',
            textStyle: TextStyle(fontSize: 15, color: Colors.white)),
        MenuItem(
            title: 'Purchase',
            textStyle: TextStyle(fontSize: 15, color: Colors.white)),
        MenuItem(
            title: 'Log Out',
            textStyle: TextStyle(fontSize: 15, color: Colors.white)),
      ],
    );
    menu.show(widgetKey: menuButtonKey);
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return Tooltip(
      verticalOffset: 25,
      margin: EdgeInsets.only(left: 100),
      message: "Click here",
      child: MaterialButton(
        padding: EdgeInsets.all(10.0),
        minWidth: 10.0,
        key: menuButtonKey,
        hoverColor: Colors.white10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(600.0))),
        onPressed: popupMenuButton,
        child: widget.profilePicture != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: Image.network(widget.profilePicture,
                    height: 60, width: 60, fit: BoxFit.cover),
              )
            : Icon(
                FontAwesomeIcons.solidUserCircle,
                size: 60,
                color: Colors.white,
              ),
      ),
    );
  }
}
