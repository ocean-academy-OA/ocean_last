import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/notification.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:provider/provider.dart';

class Notification_onclick extends StatefulWidget {
  const Notification_onclick({
    @required this.isVisible,
  });

  final bool isVisible;

  @override
  _Notification_onclickState createState() => _Notification_onclickState();
}

class _Notification_onclickState extends State<Notification_onclick> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 45,
      child: Visibility(
        visible: widget.isVisible,
        child: Container(
          color: Colors.white,
          height: 400,
          width: 400,
          child: Column(
            children: [
              // Stack(
              //   children: [
              //     Container(
              //       height: 10,
              //       width: double.infinity,
              //       color: Colors.white,
              //       // color: Color(0xff0091D2),
              //     ),
              //     Positioned(
              //       right: 23,
              //       child: ClipPath(
              //         clipper: TraingleClipPath(),
              //         child: Container(
              //           height: 10,
              //           width: 10,
              //           color: Colors.black,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  child: Image.asset("images/python.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(1),
                                  child: Container(
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      // softWrap: true,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  child: Image.asset("images/python.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(1),
                                  child: Container(
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      // softWrap: true,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  child: Image.asset("images/python.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(1),
                                  child: Container(
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      // softWrap: true,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  height: 100,
                                  width: 100,
                                  child: Image.asset("images/python.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Container(
                                    child: Text(
                                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      // softWrap: true,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<Routing>(context, listen: false)
                          .updateRouting(widget: User());
                    },
                    child: Container(
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 20, decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
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
