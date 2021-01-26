import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/courses_widget.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDetails extends StatefulWidget {
  String course;
  String trainer;
  String sess;
  String desc;

  CourseDetails({this.course, this.sess, this.trainer, this.desc});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  // void subMessage() async {
  //   final message = await _firestore
  //       .collection('course')
  //       .doc('4dLAoNlHzfdUeT2Gkwk6')
  //       .collection("syllabus")
  //       .get();
  //   for (var courses in message.docs) {
  //     print(courses.data());
  //   }
  //   // print(syllabus);
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // subMessage();
  // }

  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 260.0,
                  padding:
                      EdgeInsets.symmetric(horizontal: 100.0, vertical: 60.0),
                  color: Color(0xff004B71),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<Routing>(context, listen: false)
                                  .updateRouting(widget: Course());
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                          Text(
                            'Online Course',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                          ),
                        ],
                      ),
                      Text(
                        '${widget.course} Full Package Course',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        '${widget.trainer}',
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Online Course',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '${widget.sess} Session',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.video,
                                  color: Colors.white,
                                  size: 25.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'By Zoom',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100.0, vertical: 60.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CourseDetailsHeadingText(
                                      title: 'Course Details'),
                                  SizedBox(height: 30.0),
                                  Container(
                                    width: 1100.0,
                                    child: Text(
                                      "${widget.desc}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[700]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1100,
                          padding: EdgeInsets.symmetric(horizontal: 100.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CourseDetailsHeadingText(
                                title: 'Table Of Contents',
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('course')
                                    .doc(widget.course)
                                    .collection('syllabus')
                                    .snapshots(),
                                // ignore: missing_return
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Text("Loading.....");
                                  } else {
                                    final messages = snapshot.data.docs;
                                    List<CourseDescription> courseDetails = [];
                                    //List<String> subjects = [];
                                    for (var message in messages) {
                                      // if (message.data()['coursename'] == widget.course) {
                                      final messageText =
                                          message.data()[widget.trainer];
                                      final messageSender =
                                          message.data()[widget.course];
                                      final messageSession =
                                          message.data()[widget.sess];
                                      final messageCoursedescription =
                                          message.data()[widget.desc];
                                      final messageTopic =
                                          message.data()['topic'];
                                      final messageContent1 =
                                          message.data()['content1'];
                                      final messageContent2 =
                                          message.data()['content2'];
                                      final messageContent3 =
                                          message.data()['content3'];
                                      final messageDubble = CourseDescription(
                                        trainername: messageText,
                                        coursename: messageSender,
                                        session: messageSession,
                                        coursedescription:
                                            messageCoursedescription,
                                        topic: messageTopic,
                                        content1: messageContent1,
                                        content2: messageContent2,
                                        content3: messageContent3,
                                      );
                                      courseDetails.add(messageDubble);
                                      // subjects.add(message.data()["coursename"]);
                                      // print(subjects);
                                      print(messages);
                                      // }
                                    }
                                    return Column(
                                      children: courseDetails,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: MessageBubble.visiblity,
              child: Positioned(
                top: 140,
                right: 150.0,
                child: Container(
                  height: 500.0,
                  width: 500.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 30.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      // StreamBuilder<QuerySnapshot>(
                      //   stream: _firestore.collection('course').snapshots(),
                      //   // ignore: missing_return
                      //   builder: (context, snapshot) {
                      //     if (!snapshot.hasData) {
                      //       return Text("Loading.....");
                      //     } else {
                      //       final messages = snapshot.data.docs;
                      //       List<VisibleWidget> courseImage = [];
                      //       for (var message in messages) {
                      //         if (message.data()['coursename'] ==
                      //             widget.course) {
                      //           final contentImage = message.data()['img'];
                      //           final contentRate = message.data()['rate'];
                      //           final contentImage1 =
                      //               message.data()['content1'];
                      //           final contentImage2 =
                      //               message.data()['content2'];
                      //           final contentImage3 =
                      //               message.data()['content3'];
                      //           final messageImage = VisibleWidget(
                      //             image: contentImage,
                      //             collection1: contentImage1,
                      //             collection2: contentImage2,
                      //             collection3: contentImage3,
                      //             rupees: contentRate,
                      //           );
                      //           courseImage.add(messageImage);
                      //           //print('${CourseEnroll.subject} ggg');
                      //         }
                      //       }
                      //
                      //       return Column(
                      //         children: courseImage,
                      //       );
                      //     }
                      //   },
                      // ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _firestore.collection('course').snapshots(),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Loading.....");
                          } else {
                            final messages = snapshot.data.docs;
                            List<VisibleWidget> courseImage = [];
                            //List<String> subjects = [];
                            for (var message in messages) {
                              if (message.data()['coursename'] ==
                                  CourseEnroll.selectedCourse) {
                                final courseRate = message.data()['rate'];
                                final contentImage = message.data()['img'];
                                final imageContent1 =
                                    message.data()['content1'];
                                final imageContent2 =
                                    message.data()['content2'];

                                final imageContent3 =
                                    message.data()['content3'];

                                final images = VisibleWidget(
                                  image: contentImage,
                                  collection1: imageContent1,
                                  collection2: imageContent2,
                                  collection3: imageContent3,
                                  rupees: courseRate,
                                );

                                courseImage.add(images);
                              }
                            }

                            print("${widget.course} jaya");
                            print("${courseImage}");
                            return Column(
                              children: courseImage,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Expansion extends StatelessWidget {
  String heading;
  String collection1;
  String collection2;
  String collection3;

  Expansion({
    this.collection1,
    this.heading,
    this.collection2,
    this.collection3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1.0)),
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Column(
        children: [
          ExpansionTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                heading,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            children: [
              Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        collection1,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        collection2,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        collection3,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CourseDescription extends StatelessWidget {
  String coursename;
  String trainername;
  String session;
  String coursedescription;
  String topic;
  String content1;
  String content2;
  String content3;
  CourseDescription(
      {this.coursename,
      this.trainername,
      this.session,
      this.coursedescription,
      this.topic,
      this.content1,
      this.content3,
      this.content2});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Expansion(
          heading: "$topic",
          collection1: '$content1',
          collection2: '$content2',
          collection3: '$content3',
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

class CourseDetailsHeadingText extends StatelessWidget {
  CourseDetailsHeadingText({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
    );
  }
}

class VisibleWidget extends StatelessWidget {
  String image;
  String collection1;
  String collection2;
  String collection3;
  String rupees;

  VisibleWidget({
    this.collection1,
    this.image,
    this.collection2,
    this.collection3,
    this.rupees,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage('${image}'),
                  // width: 350.0,
                  // height: 100.0,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.rupeeSign),
                      Text(
                        '$rupees',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  RawMaterialButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.blue),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.blue, width: 2.0)),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 15.0,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                      child: Text(
                        'Python is powerful programming language',
                        style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 15.0,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                      child: Text(
                        'Python is powerful programming language',
                        style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 15.0,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                      child: Text(
                        'Python is powerful programming language',
                        style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
