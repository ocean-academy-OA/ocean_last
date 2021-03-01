import 'package:flutter/material.dart';

class WebinarFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 100,
            color: Colors.grey[200],
            child: Image.network('images/webinar/oa logo.svg'),
          )
        ],
      ),
    );
  }
}
