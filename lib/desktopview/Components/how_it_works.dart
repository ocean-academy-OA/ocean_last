import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/comment.dart';
import 'package:ocean_project/desktopview/Components/main_title_widget.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/text.dart';

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[100],
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 340,
            right: 10,
            child: Transform.rotate(
                angle: -170.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  height: 30.0,
                  width: 150.0,
                )),
          ),
          Positioned(
            top: 350,
            right: -200,
            child: Transform.rotate(
                angle: -170.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  height: 70.0,
                  width: 400.0,
                )),
          ),
          Positioned(
            bottom: 0,
            left: -200,
            child: Icon(
              FontAwesomeIcons.dotCircle,
              size: 400.0,
              color: Colors.grey[200],
            ),
          ),
          Positioned(
            child: Icon(
              FontAwesomeIcons.audible,
              size: 300,
              color: Colors.grey[200],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainTitleWidget(
                    title: 'How It Works',
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                title: "We provide training in both Online and Offline modes",
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'images/local_lesson.gif',
                        width: 400.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Offline Training',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue[200],
                              fontWeight: FontWeight.bold,
                              fontFamily: kfontname),
                        ),
                      ),
                      Container(
                        //padding: EdgeInsets.all(10.0),
                        width: 400.0,
                        child: Text(
                          offlinetrainingcontent,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 16.0,
                              fontFamily: kfontname,
                              color: kcontentcolor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'images/online_lesson.gif',
                        width: 400.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Online Live Training',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue[200],
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontname,
                          ),
                        ),
                      ),
                      Container(
                        //padding: EdgeInsets.all(10.0),
                        width: 400.0,
                        child: Text(
                          onlinetrainingcontent,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 16.0,
                              fontFamily: kfontname,
                              color: kcontentcolor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'images/online_lesson.gif',
                        width: 400.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Online Video Training',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue[200],
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontname,
                          ),
                        ),
                      ),
                      Container(
                        //padding: EdgeInsets.all(10.0),
                        width: 400.0,
                        child: Text(
                          onlinetrainingcontent,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              height: 1.5,
                              fontSize: 16.0,
                              fontFamily: kfontname,
                              color: kcontentcolor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
