import 'dart:html';
import 'package:flutter/material.dart';

class CareerLg extends StatefulWidget {
  @override
  _CareerLgState createState() => _CareerLgState();
}

class _CareerLgState extends State<CareerLg> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Container(
            //       padding: EdgeInsets.only(top: 20, left: 20),
            //       child: Image.asset("images/coming_soon/Group 10.png"),
            //     )
            //   ],
            // ),
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
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 250,
                          child: TextField(
                            decoration:
                                InputDecoration(border: OutlineInputBorder()),
                          ),
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
                            onPressed: () {},
                          ),
                        )
                      ],
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
