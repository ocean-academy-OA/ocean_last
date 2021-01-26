import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/certificates.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:provider/provider.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({
    @required this.isVisible,
  });

  final bool isVisible;

  @override
  _User_ProfileState createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 150,
      child: Visibility(
        visible: widget.isVisible,
        child: Container(
          height: 150,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(widget: Certificate());
                      },
                      child: Text("Certificates"),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text("My Profile"),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text("Purchase"),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Text("Logout"),
                    ),
                    SizedBox(height: 5),
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

// class TraingleClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.moveTo(5, 0.0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.lineTo(5, 0.0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
