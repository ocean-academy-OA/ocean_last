import 'package:flutter/material.dart';

class ContainerServiceWidget extends StatefulWidget {
  @override
  _ContainerServiceWidgetState createState() => _ContainerServiceWidgetState();
}

class _ContainerServiceWidgetState extends State<ContainerServiceWidget> {
  bool isTouching = false;
  @override
  Widget build(BuildContext context) {
    void mouseEnter(PointerEvent details) {
      setState(() {
        isTouching = true;
      });
    }

    void mouseExit(PointerEvent details) {
      setState(() {
        isTouching = false;
      });
    }

    return MouseRegion(
      onEnter: mouseEnter,
      onExit: mouseExit,
      child: Container(
        margin: EdgeInsets.all(40.0),
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        height: 300.0,
        width: 500.0,
        decoration: BoxDecoration(
            color: isTouching ? Colors.blue : Colors.grey[100],
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     spreadRadius: 5,
            //     blurRadius: 7,
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit_outlined,
              size: 70.0,
              color: isTouching ? Colors.white : Color(0xFF2b9dd1),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "24/7 Service",
              style: TextStyle(
                  color: isTouching == true ? Colors.white : Colors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
              style: TextStyle(
                color: isTouching == true ? Colors.white : Colors.black87,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
