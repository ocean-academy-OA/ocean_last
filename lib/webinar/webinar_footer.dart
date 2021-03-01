import 'dart:html';

import 'package:flutter/material.dart';

class WebinarFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              height: 80,
              color: Colors.grey[200],
              child: Image(
                image: NetworkImage('images/ss.svg'),
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
