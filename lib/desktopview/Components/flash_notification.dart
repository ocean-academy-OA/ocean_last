import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/constants.dart';

final _firestore = FirebaseFirestore.instance;

class FlashNotification extends StatefulWidget {
  FlashNotification({
    this.joinButton,
    this.dismissNotification,
    this.joinButtonName,
    this.webinar,
  });
  Function joinButton;
  Function dismissNotification;
  String joinButtonName = 'JOIN';
  Map webinar;
  @override
  _FlashNotificationState createState() => _FlashNotificationState();
}

class _FlashNotificationState extends State<FlashNotification> {
  @override
  Widget build(BuildContext context) {
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    print(widget.webinar);

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Webinar').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading.....");
        } else {
          final messages = snapshot.data.docs;
          List<FlashDb> webinarContent = [];

          for (var message in messages) {
            if (message.id == 'free_webinar') {
              final freeWebinarContent = message.data()['free'];
              final webinar = FlashDb(
                content: freeWebinarContent,
                joinButton: widget.joinButton,
                dismissNotification: widget.dismissNotification,
              );
              // Text('$messageText from $messageSender');
              webinarContent.add(webinar);
            } else {
              final paidWebinarContent = message.data()['paid'];
              final webinar = FlashDb(
                content: paidWebinarContent,
                joinButton: widget.joinButton,
                dismissNotification: widget.dismissNotification,
              );
              webinarContent.add(webinar);
            }
          }
          return Container(
            child: Column(
              children: webinarContent,
            ),
          );
        }
      },
    );
  }
}

class FlashDb extends StatefulWidget {
  Function joinButton;
  Function dismissNotification;
  String joinButtonName = 'JOIN';
  String content;
  FlashDb({
    this.content,
    this.joinButton,
    this.dismissNotification,
    this.joinButtonName,
  });

  @override
  _FlashDbState createState() => _FlashDbState();
}

class _FlashDbState extends State<FlashDb> {
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
                    TextSpan(text: widget.content),
                    TextSpan(
                        text: ' Value based webinar ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Now'),
                  ])),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: FlatButton(
                  child: Text(
                    "Join",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: kfontname),
                  ),
                  height: 40,
                  color: Colors.white,
                  onPressed: widget.joinButton,
                ),
              )
            ],
          ),
          IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: widget.dismissNotification),
        ],
      ),
    );
  }
}
