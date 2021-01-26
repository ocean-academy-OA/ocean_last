import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/enrool_appbar.dart';

class Certificate extends StatefulWidget {
  @override
  _CertificateState createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  bool isTouching = false;
  //final _firestore = FirebaseFirestore.instance;
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

    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                splashColor: Colors.white,
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(),
                  width: 213,
                  child: Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: Colors.blue,
                        size: 70,
                      ),
                      Text(
                        'Certificate',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MouseRegion(
                onEnter: mouseEnter,
                onExit: mouseExit,
                child: Wrap(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      height: 220.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 265,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // color: isTouching
                                  //     ? Colors.grey[100]
                                  //     : Colors.transparent
                                  color: Colors.blue,
                                ),
                                child: Image.asset(
                                  "images/lap.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Python Certificate",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      height: 220.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 265,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset(
                              "images/lap.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Python Certificate",
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
