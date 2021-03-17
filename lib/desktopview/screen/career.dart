import 'package:flutter/material.dart';

class Career extends StatefulWidget {
  @override
  _CareerState createState() => _CareerState();
}

class _CareerState extends State<Career> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.only(right: 70),
              height: 190,
              width: 300,
              child: Image.asset(
                'images/coming_soon/Group 10.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 50),
              child: Image.asset('images/coming_soon/Group 11.png'),
            )
          ],
        )
      ],
    );
  }
}
