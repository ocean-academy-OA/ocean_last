import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/courses_widget.dart';
import 'package:ocean_project/desktopview/Components/material_button.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/about_us_screen.dart';
import 'package:ocean_project/desktopview/screen/contact_us.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:ocean_project/desktopview/screen/services.dart';
import 'package:provider/provider.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

subscribeDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thanks for Subscribe',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset('images/tick-gif.gif'),
            ],
          ),
        ),
      );
    },
  );
}

subscribeFailedDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Check your Email',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Image.asset('images/wrong-symbol.gif'),
            ],
          ),
        ),
      );
    },
  );
}

class DesktopFooterMd extends StatefulWidget {
  @override
  _DesktopFooterMdState createState() => _DesktopFooterMdState();
}

class _DesktopFooterMdState extends State<DesktopFooterMd> {
  TextEditingController _subscribe = TextEditingController();

  void getData() async {
    http.Response response = await http.get(
        'http://free-webinar-registration.herokuapp.com/?name=Brinda&email=${_subscribe.text}&type=subscribe');

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 650,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 80),
        color: Color(0xFC004478),
        child: Column(
          children: [
            Container(
              height: 270,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: 320,
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<Routing>(context, listen: false)
                                  .updateRouting(widget: Home());
                            },
                            child: Text(
                              'OCEAN ACADEMY',
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: kfontname),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: 420,
                          child: Text(
                            'Ocean was founded on the principle of building and implementing'
                            'great ideas that drive progress for the students ond clients',
                            style: TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontSize: 18.0,
                                fontFamily: kfontname),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 11),
                    // color: Colors.grey[800],
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                NavbarRouting.menu.updateAll((key, value) =>
                                    NavbarRouting.menu[key] = false);
                                NavbarRouting.menu["Contact Us"] = true;
                              });
                              Provider.of<Routing>(context, listen: false)
                                  .updateRouting(widget: ContactUs());
                              Provider.of<MenuBar>(context, listen: false)
                                  .updateMenu(widget: NavbarRouting()
                                      // color: text ? Colors.blue : Color(0xFF155575),
                                      );
                            },
                            child: Container(
                                child: Text(
                              'CONTACT US',
                              style: kbottom,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                NavbarRouting.menu.updateAll((key, value) =>
                                    NavbarRouting.menu[key] = false);
                                NavbarRouting.menu["Services"] = true;
                              });
                              Provider.of<Routing>(context, listen: false)
                                  .updateRouting(widget: Service());
                              Provider.of<MenuBar>(context, listen: false)
                                  .updateMenu(widget: NavbarRouting());
                            },
                            child: Container(
                                child: Text(
                              'SERVICES',
                              style: kbottom,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                NavbarRouting.menu.updateAll((key, value) =>
                                    NavbarRouting.menu[key] = false);
                                NavbarRouting.menu["Course"] = true;
                              });
                              Provider.of<Routing>(context, listen: false)
                                  .updateRouting(widget: Course());
                              Provider.of<MenuBar>(context, listen: false)
                                  .updateMenu(widget: NavbarRouting()
                                      // color: text ? Colors.blue : Color(0xFF155575),
                                      );
                            },
                            child: Container(
                                child: Text(
                              'COURSES',
                              style: kbottom,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          child: Container(
                              child: Text(
                            'FAQ',
                            style: kbottom,
                          )),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                            child: Text(
                          'HELP',
                          style: kbottom,
                        )),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          children: [
                            Container(
                                width: 180,
                                alignment: Alignment.center,
                                child: footerMouseRegion(
                                    text: "About Us", widget: AboutUs())),
                            SizedBox(height: 20.0),
                            Container(
                                width: 180,
                                alignment: Alignment.center,
                                child: footerMouseRegion(text: "WORK WITH US")),
                            SizedBox(height: 20.0),
                            Container(
                                width: 180,
                                alignment: Alignment.center,
                                child: footerMouseRegion(
                                    text: "PRIVATE POLICIES")),
                            SizedBox(height: 20.0),
                            Container(
                                width: 180,
                                alignment: Alignment.center,
                                child:
                                    footerMouseRegion(text: "PRESS ENQUIRES")),
                            SizedBox(height: 20.0),
                            Container(
                                width: 230,
                                alignment: Alignment.center,
                                child: footerMouseRegion(
                                    text: "TERMS & CONDITIONS")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      // color: Colors.grey[600],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              '0413-2238675',
                              style: kbottom,
                            ),
                            //padding: EdgeInsets.only(left: 50.0),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                              child: Text(
                            'oceanacademy@gmail.com',
                            style: kbottom,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 200.0,
                        child: TextField(
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          controller: _subscribe,
                          decoration: InputDecoration(
                            hintText: 'Enter your Email',
                            hintStyle: kbottom,

                            // contentPadding: EdgeInsets.only(
                            //     top: 10, bottom: 10, left: 38),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[200], width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 16),
                        child: FlatButton(
                          color: Colors.white,
                          minWidth: 20,
                          height: 63.0,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Icon(FontAwesomeIcons.bell),
                          ),
                          // shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.all(
                          //         Radius.circular(5.0)),
                          //     side: BorderSide(
                          //       color: Colors.white,
                          //       width: 2.0,
                          //     )),
                          onPressed: () {
                            if (validateEmail(_subscribe.text)) {
                              _firestore
                                  .collection('subscribed user')
                                  .doc(_subscribe.text)
                                  .set({
                                'Email': _subscribe.text,
                              });
                              getData();

                              subscribeDialog(context);
                              _subscribe.clear();
                            } else {
                              subscribeFailedDialog(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.facebookF,
                            onPressed: () {},
                          ),
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.googlePlusG,
                            onPressed: () {},
                          ),
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.linkedinIn,
                            onPressed: () {},
                          ),
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.twitter,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  MouseRegion footerMouseRegion({text, widget}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            NavbarRouting.menu
                .updateAll((key, value) => NavbarRouting.menu[key] = false);
            NavbarRouting.menu[text] = true;
            print(text);
          });
          Provider.of<Routing>(context, listen: false)
              .updateRouting(widget: widget);
          Provider.of<MenuBar>(context, listen: false)
              .updateMenu(widget: NavbarRouting()
                  // color: text ? Colors.blue : Color(0xFF155575),
                  );
        },
        child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: kbottom,
            )),
      ),
    );
  }
}
