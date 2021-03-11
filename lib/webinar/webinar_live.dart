import 'package:flutter/material.dart';

class LiveWebinar extends StatefulWidget {
  @override
  _LiveWebinarState createState() => _LiveWebinarState();
}

class _LiveWebinarState extends State<LiveWebinar> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Live Webinar',
      style: TextStyle(fontSize: 100),
    ));
  }
}
