import 'package:flutter/material.dart';

class Career extends StatefulWidget {
  @override
  _CareerState createState() => _CareerState();
}

class _CareerState extends State<Career> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(
            'Coming soon',
            style: TextStyle(fontSize: 60),
          ),
        ),
        Image.network('https://ohcguide.com/assets/comingsoon.svg'),
      ],
    );
  }
}
