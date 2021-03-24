import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/enroll_new.dart';
import 'package:ocean_project/desktopview/Components/certificates.dart';
import 'package:ocean_project/desktopview/Components/enrool_appbar.dart';

import 'package:ocean_project/desktopview/Components/purchase.dart';

import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/new_user_screen/edit_profile.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable, camel_case_types
class User_Profile extends StatefulWidget {
  bool isVisible;
  User_Profile({this.isVisible});

  @override
  _User_ProfileState createState() => _User_ProfileState();
}

// ignore: camel_case_types
class _User_ProfileState extends State<User_Profile> {
  @override
  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int x = (prefs.getInt('login') ?? 0);
    LogIn.registerNumber = (prefs.getString('user') ?? null);
    MenuBar.stayUser = LogIn.registerNumber;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    print("Checkkkkkkk${widget.isVisible}");

    return Positioned(
      top: 0,
      right: 150,
      child: Visibility(
        visible: ContentWidget.isShow,
        child: Container(
          width: 200,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // color: Colors.white,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ]),
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FlatButton(
                      child: Text('Certificates'),
                      onPressed: () {
                        setState(() {
                          ContentWidget.isShow = !ContentWidget.isShow;
                        });

                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: Certificate());
                        Provider.of<MenuBar>(context, listen: false)
                            .updateMenu(widget: AppBarWidget());
                      },
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      child: Text('My profile'),
                      onPressed: () {
                        setState(() {
                          ContentWidget.isShow = !ContentWidget.isShow;
                        });

                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: EditProfile());
                        Provider.of<MenuBar>(context, listen: false)
                            .updateMenu(widget: AppBarWidget());
                      },
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      child: Text('Purchase'),
                      onPressed: () {
                        setState(() {
                          ContentWidget.isShow = !ContentWidget.isShow;
                        });

                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: Purchase());
                        Provider.of<MenuBar>(context, listen: false)
                            .updateMenu(widget: AppBarWidget());
                      },
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      child: Text('Log Out'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        // await prefs.setInt('login', 0);
                        await prefs.setString('user', null);
                        LogIn.registerNumber = null;
                        MenuBar.stayUser = null;
                        setState(() {
                          ContentWidget.isShow = !ContentWidget.isShow;

                          Provider.of<Routing>(context, listen: false)
                              .updateRouting(widget: Home());
                          Provider.of<MenuBar>(context, listen: false)
                              .updateMenu(widget: NavbarRouting());
                        });
                        print('SingOut Code');
                        print(MenuBar.stayUser);
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
