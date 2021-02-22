import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

class FlashNotification extends StatefulWidget {
  FlashNotification({this.onPressed});
  Function onPressed;
  @override
  _FlashNotificationState createState() => _FlashNotificationState();
}

class _FlashNotificationState extends State<FlashNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            children: [
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      children: [
                    TextSpan(text: 'Get free access to our'),
                    TextSpan(
                        text: ' Value based webinar ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Now'),
                  ])),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  child: Text(
                    'JOIN',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: kfontname),
                  ),
                  height: 40,
                  color: Colors.white,
                  onPressed: () {},
                ),
              )
            ],
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: widget.onPressed,
          ),
        ],
      ),
    );
  }
}
