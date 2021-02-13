import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

// ignore: must_be_immutable
class TextToImage extends StatelessWidget {
  String topic;
  String content;
  String photo;
  TextToImage({this.topic, this.content, this.photo});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(left: 50.0, right: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  style: TextStyle(
                      color: Color(0xff0091d2),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontname),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(content,
                    textAlign: TextAlign.justify, style: contentTextStyle),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 300.0,
                    height: 300.0,
                    //height: 300,
                    margin: EdgeInsets.fromLTRB(120.0, 0.0, 0.0, 50.0),
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        image: AssetImage(photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Container(
                    width: 300.0,
                    height: 300.0,
                    margin: EdgeInsets.fromLTRB(20.0, 100.0, 0.0, 20.0),
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                      child: Image(
                        image: AssetImage(photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff0091d2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
