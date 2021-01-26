import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/course_details.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:provider/provider.dart';

class CoursesWidget extends StatefulWidget {
  // bool online;
  //
  // CoursesWidget({
  //   this.online,
  // });

  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  final _firestore = FirebaseFirestore.instance;

  // void getMessage() async {
  //   final message = await _firestore.collection('contact_us').get();
  //   print(message.docs);
  //
  //   for (var courses in message.docs) {
  //     print(courses.data()["Email"]);
  //   }
  // }
  List<String> subjects = [];
  @override
  void initState() {
    // TODO: implement initState
    // getMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        (Course.isSelected[0] == true)
            ? StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<MessageBubble> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageSession = message.data()['session'];
                      final messageTime = message.data()['time'];
                      final messageImage = message.data()['img'];
                      final messageDescription =
                          message.data()['coursedescription'];
                      final messageBubble = MessageBubble(
                        trainername: messageText,
                        coursename: messageSender,
                        session: messageSession,
                        time: messageTime,
                        image: messageImage,
                        description: messageDescription,
                      );
                      // Text('$messageText from $messageSender');
                      messageBubbles.add(messageBubble);
                      subjects.add(message.data()["coursename"]);
                      print(subjects);
                    }

                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: messageBubbles,
                    );
                  }
                },
              )
            : StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('offline_course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<MessageBubble> offlineCourse = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageSession = message.data()['session'];
                      final messageTime = message.data()['time'];
                      final messageImage = message.data()['img'];
                      final messageDescription =
                          message.data()['coursedescription'];
                      final messageCourse = MessageBubble(
                        trainername: messageText,
                        coursename: messageSender,
                        session: messageSession,
                        time: messageTime,
                        image: messageImage,
                        description: messageDescription,
                      );
                      // Text('$messageText from $messageSender');
                      offlineCourse.add(messageCourse);
                      subjects.add(message.data()["coursename"]);
                      print(subjects);
                    }

                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: offlineCourse,
                    );
                  }
                },
              )
      ],
    );
  }
}

class MessageBubble extends StatefulWidget {
  static bool visiblity = false;
  MessageBubble(
      {this.coursename,
      this.trainername,
      this.session,
      this.time,
      this.image,
      this.description});
  final String coursename;
  final String trainername;
  final String session;
  final String time;
  final String image;
  final String description;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          MessageBubble.visiblity = true;
        });
        print(widget.coursename);
        Provider.of<Routing>(context, listen: false).updateRouting(
            widget: CourseDetails(
          course: widget.coursename,
          trainer: widget.trainername,
          sess: widget.time,
          desc: widget.description,
        ));
      },
      child: Container(
        margin: EdgeInsets.all(35.0),
        //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        height: 310.0,
        width: 350.0,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: NetworkImage('${widget.image}'),
                // width: 350.0,
                // height: 100.0,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "${widget.coursename} full package course | ${widget.trainername} | Ocean Academy",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Color(0xff3B7EB6),
                      ),
                      Text("${widget.time} hr"),
                      Icon(
                        Icons.web_sharp,
                        color: Color(0xff3B7EB6),
                      ),
                      Text("${widget.session} sessions"),
                      Icon(
                        Icons.video_call,
                        color: Color(0xff3B7EB6),
                      ),
                      Text("by zoom"),
                      Text(
                        "Click Here",
                        style: TextStyle(
                          color: Color(0xff3B7EB6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
