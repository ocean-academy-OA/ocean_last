import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_project/desktopview/screen/career/career_layout.dart';
import 'package:ocean_project/desktopview/screen/footer.dart';

final _firestore = FirebaseFirestore.instance;

class CareerLg extends StatefulWidget {
  @override
  _CareerLgState createState() => _CareerLgState();
}

class _CareerLgState extends State<CareerLg> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validation = false;
  String email;

  Widget buildEmail() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      autovalidate: validation,
      validator: (value) =>
          EmailValidator.validate(value) ? null : "please enter a valid email",
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(fontSize: 0),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Email',
        labelText: 'Email',
      ),
      controller: CareerLayout.emailController,
      onChanged: (value) {
        email = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 280,
                    height: 240,
                    padding: EdgeInsets.only(left: 50, top: 50),
                    child: Image.asset(
                      "images/coming_soon/Group 13.png",
                      fit: BoxFit.cover,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 7),
                          child: Text(
                            'We are coming with something',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 7),
                          child: Text(
                            'AMAZING',
                            style: TextStyle(
                                fontSize: 50,
                                letterSpacing: 5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: Text(
                            'SUBSCRIBE AND STAY UPDATED',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 250,
                                child: buildEmail(),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: 30,
                                ),
                                height: 52,
                                child: FlatButton(
                                  color: Colors.blue,
                                  padding: EdgeInsets.zero,
                                  child: Icon(
                                    Icons.send_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _firestore
                                          .collection("subscribed user")
                                          .doc(email)
                                          .set({"Email": email});
                                      setState(() {
                                        validation = false;
                                      });
                                      subscribeDialog(context);
                                      CareerLayout.emailController.clear();
                                    } else {
                                      setState(() {
                                        validation = true;
                                      });
                                      subscribeFaildDialog(context);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 450,
                          // padding: EdgeInsets.only(left: 50),
                          child: Image.asset(
                            'images/coming_soon/Group 11.png',
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: -50,
          left: -200,
          child: ClipPath(
            clipper: LinePathClass(),
            child: Container(
              color: Colors.blue[100],
              height: 250,
              width: 470,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -215,
          child: ClipPath(
            clipper: LinePathClass(),
            child: Container(
              color: Colors.blue[200],
              height: 260,
              width: 470,
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: ClipPath(
            clipper: LinePathClass(),
            child: Container(
              color: Colors.blue[100],
              height: 250,
              width: 470,
            ),
          ),
        ),
      ],
    );
  }
}

class LinePathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // path.moveTo(250, size.height);
    // path.lineTo(0.0, size.height);
    // path.lineTo(size.width, size.height);
    path.moveTo(250, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(250, 0.0);

    //jaya design
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(130, 0.0);
    // path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
