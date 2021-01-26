import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/Components/enrool_appbar.dart';

import 'course_enrole.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Notification',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('notifications')
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading.....");
                            } else {
                              final messages = snapshot.data.docs;
                              List<Jaya> data = [];

                              for (var message in messages) {
                                final messageImage = message.data()['img'];
                                final messageDescription =
                                    message.data()['description'];
                                final sample = Jaya(
                                  imagepath: messageImage,
                                  description: messageDescription,
                                );
                                // Text('$messageText from $messageSender');
                                data.add(sample);
                              }
                              return Column(
                                children: data,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
    // );
  }
}

class Jaya extends StatelessWidget {
  Jaya({this.imagepath, this.description});
  String imagepath;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(5.0),
              //height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(2)),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 120,
                      width: 50,
                      // color: Colors.blue,
                      child: Image.network("$imagepath"),
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(
                    flex: 10,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child:
                          Text("$description", style: TextStyle(fontSize: 15)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
