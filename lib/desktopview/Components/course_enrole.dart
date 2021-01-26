import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_project/desktopview/Components/courses_widget.dart';
import 'package:ocean_project/desktopview/Components/enrool_appbar.dart';
import 'package:ocean_project/desktopview/Components/main_notification.dart';
import 'package:ocean_project/desktopview/Components/user_profile.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/course_details.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL() async {
  const url =
      'https://us04web.zoom.us/j/5175653439?pwd=MEI0R1VjQ2FDMitpbkV6RHpSWURndz09';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

final _firestore = FirebaseFirestore.instance;

class CoursesView extends StatefulWidget {
  String course;
  String trainer;
  String sess;
  String desc;

  CoursesView({this.course, this.sess, this.trainer, this.desc});
  @override
  _CoursesViewState createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBarWidget(),
        ),
        body: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    //width: 250.0,
                    color: Color(0xff006793),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Text(
                                "Courses",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream:
                                    _firestore.collection('course').snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("Loading.....");
                                  } else {
                                    final messages = snapshot.data.docs;
                                    List<CourseEnroll> courseEnroll = [];
                                    for (var message in messages) {
                                      final messageSender =
                                          message.data()['coursename'];
                                      final messageEnroll = CourseEnroll(
                                        coursename: messageSender,
                                      );
                                      courseEnroll.add(messageEnroll);
                                      //print('${CourseEnroll.subject} ggg');
                                    }

                                    return Column(
                                      children: courseEnroll,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              MaterialButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                height: 60.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                color: Color(0xff014965),
                                minWidth: double.infinity,
                                onPressed: () {},
                                child: Text(
                                  "Enroll New Course",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    //margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(40.0),
                    width: 1300,
                    color: Colors.white,
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: _firestore.collection('course').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading.....");
                            } else {
                              final messages = snapshot.data.docs;
                              List<CourseContent> courseContent = [];
                              //List<String> subjects = [];
                              for (var message in messages) {
                                if (message.data()['coursename'] ==
                                    CourseEnroll.selectedCourse) {
                                  final messageText = message.data()['name'];
                                  final messageSender =
                                      message.data()['coursename'];
                                  final messageTrainer =
                                      message.data()['trainername'];
                                  final messageFinish =
                                      message.data()['finish'];
                                  final messageCoursedescription =
                                      message.data()['coursedescription'];
                                  final messageTopic =
                                      message.data()['topicCover'];
                                  final messageContent1 =
                                      message.data()['title'];
                                  final messageContent2 =
                                      message.data()['schedule'];
                                  final messageContent3 =
                                      message.data()['time'];
                                  final messageContent = CourseContent(
                                    name: messageText,
                                    coursename: messageSender,
                                    finish: messageFinish,
                                    coursedescription: messageCoursedescription,
                                    topicCover: messageTopic,
                                    title: messageContent1,
                                    schedule: messageContent2,
                                    time: messageContent3,
                                    trainername: messageTrainer,
                                  );
                                  courseContent.add(messageContent);
                                }
                              }
                              return Column(
                                children: courseContent,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Notification_onclick(isVisible: CourseContent.isVisible),
            User_Profile(isVisible: CourseContent.isShow)
          ],
        ),
      ),
    );
  }
}

class CourseEnroll extends StatefulWidget {
  String coursename;
  static String selectedCourse;
  static List<String> subject = [];

  CourseEnroll({
    this.coursename,
  });

  @override
  _CourseEnrollState createState() => _CourseEnrollState();
}

class _CourseEnrollState extends State<CourseEnroll> {
  Map menu = {};

  void getMessage() async {
    final message = await _firestore.collection('course').get();

    for (var courses in message.docs) {
      CourseEnroll.subject.add(courses.data()['coursename']);
    }
    print("${CourseEnroll.subject} thamizh");
    List<bool> isSubject = [];
    for (int i = 0; i < CourseEnroll.subject.length; i++) {
      if (i == 0) {
        isSubject.add(true);
      }
      isSubject.add(false);
    }
    print("${isSubject} bool");
    for (int i = 0; i < CourseEnroll.subject.length; i++) {
      menu.addAll({CourseEnroll.subject[i]: isSubject[i]});
    }
    print("$menu dictionary");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListTile(
            text: '${widget.coursename}',
            widget: CourseContent(
              coursename: "${CourseEnroll.selectedCourse}",
            )),
      ],
    );
  }

  ListTile buildListTile({widget, text}) {
    print("MethodListTile $text");
    return ListTile(
      onTap: () {
        setState(() {
          //contentWidget = widget
          menu.updateAll((key, value) => menu[key] = false);
          menu[text] = true;

          CourseEnroll.selectedCourse = text;
          print(menu);
        });
        print("jayalatha ${CourseEnroll.selectedCourse}");
        Provider.of<Routing>(context, listen: false)
            .updateRouting(widget: widget);
      },
      leading: Icon(
        Icons.close,
        size: 20.0,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: menu[text] == true ? Colors.blue : Colors.white,
          fontSize: 20.0,
        ),
      ),
      hoverColor: Colors.yellow,
    );
  }
}

class CourseContent extends StatefulWidget {
  static bool isVisible = false;
  static bool isShow = false;
  final String coursename;
  final String trainername;
  final String name;
  final String finish;
  final String coursedescription;
  final String topicCover;
  final String title;
  final String time;
  final String schedule;
  CourseContent(
      {this.coursename,
      this.name,
      this.finish,
      this.coursedescription,
      this.title,
      this.time,
      this.schedule,
      this.topicCover,
      this.trainername});

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.baseline,
              //textBaseline: TextBaseline.ideographic,
              children: [
                Text(
                  "☺",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hi jaya,you are enroll in ${CourseEnroll.selectedCourse} course",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textBaseline: TextBaseline.ideographic,
              //crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                Row(
                  children: [
                    Text(
                      " ${widget.topicCover} topics covered",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      " ${widget.finish} days to finish  end soon",
                      style: TextStyle(color: Colors.blue, fontSize: 20.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlineButton(
                      borderSide: BorderSide(color: Colors.blue),
                      padding: EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 17.0),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          MessageBubble.visiblity = false;
                        });
                        Provider.of<Routing>(context, listen: false)
                            .updateRouting(
                                widget: CourseDetails(
                          course: widget.coursename,
                          trainer: widget.trainername,
                          sess: widget.time,
                          desc: widget.coursedescription,
                        ));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.menu_book,
                            color: Color(0xFF0091D2),
                            size: 30.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "View Syllabus",
                            style: TextStyle(
                              color: Color(0xFF0091D2),
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              //margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(15.0),
              //height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.title}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("${widget.coursedescription}"),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Scheduled At",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined),
                          Text("${widget.schedule}"),
                          SizedBox(
                            width: 20.0,
                          ),
                          Icon(Icons.access_time),
                          Text("${widget.time}"),
                        ],
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            padding: EdgeInsets.all(20.0),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(05.0))),
                            onPressed: _launchURL,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.zoom_in_outlined,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Join here",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
