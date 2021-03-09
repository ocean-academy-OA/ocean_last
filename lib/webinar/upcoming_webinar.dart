import 'package:flutter/material.dart';

class UpcomingWebinar extends StatefulWidget {
  @override
  _UpcomingWebinarState createState() => _UpcomingWebinarState();
}

class _UpcomingWebinarState extends State<UpcomingWebinar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.network('https://ey5me.csb.app/happy.svg'),
    );
  }
}
