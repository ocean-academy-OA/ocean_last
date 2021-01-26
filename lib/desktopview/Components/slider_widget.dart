import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/video_player_screen.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:ocean_project/text.dart';

import 'package:provider/provider.dart';

class SliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Slide.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homepageheading,
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontname,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    homepagecontent,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: kfontname,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0),
                    ),
                    onPressed: () {
                      Provider.of<Routing>(context, listen: false)
                          .updateRouting(widget: Course());
                    },
                    color: Colors.white,
                    textColor: textColor,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enroll now ",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: kfontname,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.87)
                ..rotateY(0.0005),
              alignment: FractionalOffset.center,
              child: Container(
                margin: EdgeInsets.only(right: 50.0),
                child: VideoPlayerScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
