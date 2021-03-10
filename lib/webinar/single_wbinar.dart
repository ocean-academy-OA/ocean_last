import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';

import 'package:ocean_project/webinar/webinar_const.dart';

import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class SingleWebinarScreen extends StatefulWidget {
  Timestamp timestamp;
  //= (10, 2021 at 10:30:00 AM UTC+5:30);
  var webinar;
  SingleWebinarScreen({this.timestamp, this.topic, this.payment});
  String topic;
  String payment;
  @override
  _SingleWebinarScreenState createState() => _SingleWebinarScreenState();
}

class _SingleWebinarScreenState extends State<SingleWebinarScreen> {
  bool timeUp;
  var sDate;

  bool isPlaying = false;

  /// Ijass work start

  /// Ijass work end
  /// jayalatha

  int yearFormat;
  int monthFormat;
  int dayFormat;
  int hourFormat;
  int minuteFormat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Navbar.visiblity = false;
    Navbar.isNotification = false;
  }

  void retriveTime() {
    print('=============');
    var year = DateFormat('y');
    var month = DateFormat('MM');
    var day = DateFormat('d');
    var hour = DateFormat('hh');
    var minute = DateFormat('mm');

    yearFormat = int.parse(year.format(widget.timestamp.toDate()));
    monthFormat = int.parse(month.format(widget.timestamp.toDate()));
    dayFormat = int.parse(day.format(widget.timestamp.toDate()));
    hourFormat = int.parse(hour.format(widget.timestamp.toDate()));
    minuteFormat = int.parse(minute.format(widget.timestamp.toDate()));

    sDate =
        DateTime(yearFormat, monthFormat, dayFormat, hourFormat, minuteFormat)
            .difference(DateTime.now())
            .inSeconds;
  }

  /// jayalatha

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   retriveTime();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              widget.payment == "free"
                  ? StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('free_webinar').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('getting data');
                        } else {
                          List<Map> upcoming = [];
                          List<Widget> wbinars = [];
                          final getFreeWebinar = snapshot.data;

                          for (var a in getFreeWebinar.docs) {
                            String name;
                            String phoneNumber;
                            String email;
                            GlobalKey<FormState> _formKey =
                                GlobalKey<FormState>();
                            final nameController = TextEditingController();
                            final emailController = TextEditingController();
                            final phoneNumberController =
                                TextEditingController();

                            Widget _buildName() {
                              return TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z]+|\s")),
                                  LengthLimitingTextInputFormatter(40),
                                ],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'name is required';
                                  } else if (value.length < 3) {
                                    return 'character should be morethan 2';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.drive_file_rename_outline),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 12),
                                  border: OutlineInputBorder(),
                                  hintText: "enter your name",
                                  labelText: 'Name',
                                ),
                                controller: nameController,
                                onChanged: (value) {
                                  name = value;
                                },
                              );
                            }

                            Widget _buildphonenumber() {
                              return TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r"^\d+\.?\d{0,2}"),
                                  ),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'phone_number is required';
                                  } else if (value.length < 10) {
                                    return 'invalid phone_number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.phone_android_outlined),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 12),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Your Number',
                                  labelText: 'Phone Number',
                                ),
                                controller: phoneNumberController,
                                onChanged: (value) {
                                  phoneNumber = value;
                                },
                              );
                            }

                            Widget _buildEmail() {
                              return TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"))
                                ],
                                validator: (value) =>
                                    EmailValidator.validate(value)
                                        ? null
                                        : "please enter a valid email",
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 12),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Your Email',
                                  labelText: 'Email',
                                ),
                                controller: emailController,
                                onChanged: (value) {
                                  email = value;
                                },
                              );
                            }

                            void getData() async {
                              http.Response response = await http.get(
                                  """ https://shrouded-fjord-03855.herokuapp.com/?name=$name&des=query&mobile=$phoneNumber&email=$email&date=date time &type=enquiry""");

                              if (response.statusCode == 200) {
                                String data = response.body;
                                print(data);
                              } else {
                                print(response.statusCode);
                              }
                            }

                            VideoPlayerController _videoController;
                            Future<void> _initializeVideoPlayerFuture;

                            final webinarVideo = a.data()['webinar video'];
                            _videoController =
                                VideoPlayerController.network(webinarVideo);

                            _initializeVideoPlayerFuture =
                                _videoController.initialize();
                            _videoController.setLooping(true);

                            List<Widget> allTopics = [];
                            Timestamp timestamp = a.data()['timestamp'];
                            var year = DateFormat('y');
                            var month = DateFormat('MM');
                            var day = DateFormat('d');
                            var hour = DateFormat('hh');
                            var minute = DateFormat('mm');
                            yearFormat =
                                int.parse(year.format(timestamp.toDate()));
                            monthFormat =
                                int.parse(month.format(timestamp.toDate()));
                            dayFormat =
                                int.parse(day.format(timestamp.toDate()));
                            hourFormat =
                                int.parse(hour.format(timestamp.toDate()));
                            minuteFormat =
                                int.parse(minute.format(timestamp.toDate()));

                            sDate = DateTime(yearFormat, monthFormat, dayFormat,
                                    hourFormat, minuteFormat)
                                .difference(DateTime.now())
                                .inSeconds;
                            final topicSubtitle = a.data()['topic subtitle'];
                            final topicTitle = a.data()['topic title'];
                            print(topicTitle.length);
                            for (var i = 0; i < topicTitle.length; i++) {
                              Column topics = Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    width: 1000,
                                    child: Text(
                                      topicTitle[i],
                                      style: kContentTitle,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    padding: EdgeInsets.only(left: 18),
                                    width: 1000,
                                    child: Text(
                                      topicSubtitle[i],
                                      style: kContentSubtitle,
                                    ),
                                  )
                                ],
                              );
                              allTopics.add(topics);
                            }

                            final course = a.data()['course'];
                            final supperTitle = a.data()['super title'];
                            final mainSubtitle = a.data()['main subtitle'];
                            final mainTitle = a.data()['main title'];
                            final trainerImage = a.data()['trainer image'];
                            final trainerName = a.data()['trainer name'];
                            final payment = a.data()['payment'];
                            final studentEnrolled =
                                a.data()['student enrolled'];
                            final webinarDuration =
                                a.data()['webinar duration'];
                            final mentorImage = a.data()['mentor image'];
                            final aboutMentor = a.data()['about mentor'];

                            if (sDate > 0) {
                              int wbinarTime = sDate;
                              if (course == widget.topic) {
                                Column singleWebinar = Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      alignment: Alignment.center,
                                      color: Colors.blue,
                                      child: Text(supperTitle,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: 1000,
                                      child: Text(
                                        mainTitle,
                                        style: kHeaddingTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: 1000,
                                      child: Text(
                                        mainSubtitle,
                                        style: TextStyle(
                                            inherit: false,
                                            fontSize: 20,
                                            color: Color(0xffFF757575),
                                            fontFamily: kfontname,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    //mentor image and name and login
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Spacer(flex: 3),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 550,
                                                    width: 800,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        trainerImage,
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 800,
                                                    height: 70,
                                                    color: Colors.grey[200],
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: Text(
                                                      'With $trainerName',
                                                      style: TextStyle(
                                                          inherit: false,
                                                          fontSize: 30,
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: kfontname,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Spacer(),
                                          // Join and timer
                                          Container(
                                            width: 450,
                                            height: 630,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // border: Border.all(color: kBlue, width: 3),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      blurRadius: 8,
                                                      offset: Offset(0, 4))
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ///TODO TextField and timer join button
                                                //timer
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 600,
                                                      height: 100,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            height: 110,
                                                            decoration:
                                                                BoxDecoration(

                                                                    // border: Border.all(
                                                                    //     color: kBlue, width: 3),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          47,
                                                                      child:
                                                                          Stack(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        children: [
                                                                          Positioned(
                                                                            bottom:
                                                                                0,
                                                                            child:
                                                                                SlideCountdownClock(
                                                                              duration: Duration(seconds: wbinarTime),
                                                                              separator: ' : ',
                                                                              textStyle: TextStyle(fontSize: 40, fontFamily: kfontname, color: kBlue),
                                                                              separatorTextStyle: TextStyle(fontSize: 35, color: kBlue),
                                                                              shouldShowDays: true,
                                                                              onDone: () {
                                                                                setState(() {
                                                                                  print(DateTime.now());
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          290,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'DAYS',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 1),
                                                                          Text(
                                                                            'HRS',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 1),
                                                                          Text(
                                                                            'MIN',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 1),
                                                                          Text(
                                                                            'SEC',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 40,
                                                      child: Text(
                                                        'Webinar Start In...',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      color: Colors.blue,
                                                      width: double.infinity,
                                                    ),
                                                  ],
                                                ),

                                                Form(
                                                  key: _formKey,
                                                  child: Container(
                                                    height: 240,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        _buildName(),
                                                        _buildphonenumber(),
                                                        _buildEmail(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 0),
                                                  child: MaterialButton(
                                                      child: Text(
                                                        'Join',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      color: kBlue,
                                                      minWidth: double.infinity,
                                                      height: 60,
                                                      elevation: 0,
                                                      hoverElevation: 0,
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          if (name != null &&
                                                              email != null &&
                                                              phoneNumber !=
                                                                  null) {
                                                            _firestore
                                                                .collection(
                                                                    'webinar Users')
                                                                .doc(
                                                                    phoneNumber)
                                                                .set({
                                                              'name': name,
                                                              'email': email,
                                                              'Phone_Number':
                                                                  phoneNumber,
                                                              'payment':
                                                                  payment ==
                                                                          'free'
                                                                      ? 'free'
                                                                      : payment
                                                            });
                                                            _firestore
                                                                .collection(payment ==
                                                                        'free'
                                                                    ? 'free_webinar'
                                                                    : 'paid_webinar')
                                                                .doc(course)
                                                                .update({
                                                              'student enrolled':
                                                                  studentEnrolled +
                                                                      1
                                                            });
                                                          }
                                                          getData();
                                                          nameController
                                                              .clear();
                                                          emailController
                                                              .clear();
                                                          phoneNumberController
                                                              .clear();
                                                        }
                                                      }),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[500],
                                                            fontSize: 16),
                                                        text:
                                                            'By clicking the button above, you are creating an account with Ocean Academy and agree to our ',
                                                        children: [
                                                          TextSpan(
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      print(
                                                                          'Privacy Policy taped');
                                                                    },
                                                              text:
                                                                  'Privacy Policy',
                                                              style: TextStyle(
                                                                  color:
                                                                      kBlue)),
                                                          TextSpan(
                                                              text: ' and '),
                                                          TextSpan(
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      print(
                                                                          'Terms of Use taped');
                                                                    },
                                                              text:
                                                                  'Terms of Use',
                                                              style: TextStyle(
                                                                  color:
                                                                      kBlue)),
                                                          TextSpan(
                                                              text:
                                                                  ', including receiving emails. '),
                                                        ]),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                          Spacer(flex: 3)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 1000,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.group,
                                                          size: 40,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '$studentEnrolled+',
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              inherit: false,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'STUDENTS ENROLLED',
                                                      style: kContentSubtitle,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                  child: Divider(
                                                    thickness: 60,
                                                    color: Colors.grey[500],
                                                  ),
                                                  width: 3,
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.timer,
                                                          size: 40,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '$webinarDuration Minutes',
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              inherit: false,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'MASTERCLASS',
                                                      style: kContentSubtitle,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                  child: Divider(
                                                    thickness: 60,
                                                    color: Colors.grey[500],
                                                  ),
                                                  width: 3,
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .award,
                                                          size: 35,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '1,000+',
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              inherit: false,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'STORIES ON OCEAN ACADEMY',
                                                      style: kContentSubtitle,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    //Watch The Preview For This Masterclass
                                    Text(
                                      'Watch The Preview For This Webinar',
                                      style: kTitle,
                                    ),
                                    SizedBox(height: 20),
                                    FutureBuilder(
                                      future: _initializeVideoPlayerFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            height: 650,
                                            width: 870,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio:
                                                          _videoController.value
                                                              .aspectRatio,
                                                      child: VideoPlayer(
                                                          _videoController),
                                                    ),
                                                    VideoProgressIndicator(
                                                      _videoController,
                                                      allowScrubbing: true,
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  child: GestureDetector(
                                                    child: Container(
                                                      height: 490,
                                                      width: 870,
                                                      color: Colors.transparent,
                                                    ),
                                                    onTap: () {
                                                      if (_videoController
                                                          .value.isPlaying) {
                                                        _videoController
                                                            .pause();
                                                      } else {
                                                        _videoController.play();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Text('Video Getting');
                                        }
                                      },
                                    ),
                                    SizedBox(height: 40),
                                    Text(
                                      'What You’ll Learn',
                                      style: kTitle,
                                    ),
                                    SizedBox(height: 40),
                                    Column(children: allTopics),

                                    SizedBox(height: 40),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 50),
                                      color: Colors.grey[200],
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'About Mentor',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 50),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                color: Colors.grey[100],
                                                height: 650,
                                                width: 500,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Text(
                                                        aboutMentor,
                                                        style: kContentSubtitle,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 50),
                                              Container(
                                                height: 650,
                                                width: 500,
                                                child: Image(
                                                  image:
                                                      NetworkImage(mentorImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                  ],
                                );
                                wbinars.add(singleWebinar);
                              }
                            }
                          }
                          return Column(children: wbinars);
                        }
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('paid_webinar').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text('getting data');
                        } else {
                          List<Map> upcoming = [];
                          List<Widget> wbinars = [];
                          final getFreeWebinar = snapshot.data;

                          for (var a in getFreeWebinar.docs) {
                            String name;
                            String phoneNumber;
                            String email;
                            GlobalKey<FormState> _formKey =
                                GlobalKey<FormState>();
                            final nameController = TextEditingController();
                            final emailController = TextEditingController();
                            final phoneNumberController =
                                TextEditingController();

                            Widget _buildName() {
                              return TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z]+|\s")),
                                  LengthLimitingTextInputFormatter(40),
                                ],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'name is required';
                                  } else if (value.length < 3) {
                                    return 'character should be morethan 2';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.drive_file_rename_outline),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 12),
                                  border: OutlineInputBorder(),
                                  hintText: "enter your name",
                                  labelText: 'Name',
                                ),
                                controller: nameController,
                                onChanged: (value) {
                                  name = value;
                                },
                              );
                            }

                            Widget _buildphonenumber() {
                              return TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r"^\d+\.?\d{0,2}"),
                                  ),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'phone_number is required';
                                  } else if (value.length < 10) {
                                    return 'invalid phone_number';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.phone_android_outlined),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 12),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Your Number',
                                  labelText: 'Phone Number',
                                ),
                                controller: phoneNumberController,
                                onChanged: (value) {
                                  phoneNumber = value;
                                },
                              );
                            }

                            Widget _buildEmail() {
                              return TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r"\s"))
                                ],
                                validator: (value) =>
                                    EmailValidator.validate(value)
                                        ? null
                                        : "please enter a valid email",
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 12),
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Your Email',
                                  labelText: 'Email',
                                ),
                                controller: emailController,
                                onChanged: (value) {
                                  email = value;
                                },
                              );
                            }

                            void getData() async {
                              http.Response response = await http.get(
                                  """ https://shrouded-fjord-03855.herokuapp.com/?name=$name&des=query&mobile=$phoneNumber&email=$email&date=date time &type=enquiry""");

                              if (response.statusCode == 200) {
                                String data = response.body;
                                print(data);
                              } else {
                                print(response.statusCode);
                              }
                            }

                            VideoPlayerController _videoController;
                            Future<void> _initializeVideoPlayerFuture;

                            final webinarVideo = a.data()['webinar video'];
                            _videoController =
                                VideoPlayerController.network(webinarVideo);

                            _initializeVideoPlayerFuture =
                                _videoController.initialize();
                            _videoController.setLooping(true);

                            List<Widget> allTopics = [];
                            Timestamp timestamp = a.data()['timestamp'];
                            var year = DateFormat('y');
                            var month = DateFormat('MM');
                            var day = DateFormat('d');
                            var hour = DateFormat('hh');
                            var minute = DateFormat('mm');
                            yearFormat =
                                int.parse(year.format(timestamp.toDate()));
                            monthFormat =
                                int.parse(month.format(timestamp.toDate()));
                            dayFormat =
                                int.parse(day.format(timestamp.toDate()));
                            hourFormat =
                                int.parse(hour.format(timestamp.toDate()));
                            minuteFormat =
                                int.parse(minute.format(timestamp.toDate()));

                            sDate = DateTime(yearFormat, monthFormat, dayFormat,
                                    hourFormat, minuteFormat)
                                .difference(DateTime.now())
                                .inSeconds;
                            final topicSubtitle = a.data()['topic subtitle'];
                            final topicTitle = a.data()['topic title'];
                            print(topicTitle.length);
                            for (var i = 0; i < topicTitle.length; i++) {
                              Column topics = Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    width: 1000,
                                    child: Text(
                                      topicTitle[i],
                                      style: kContentTitle,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    padding: EdgeInsets.only(left: 18),
                                    width: 1000,
                                    child: Text(
                                      topicSubtitle[i],
                                      style: kContentSubtitle,
                                    ),
                                  )
                                ],
                              );
                              allTopics.add(topics);
                            }

                            final course = a.data()['course'];
                            final supperTitle = a.data()['super title'];
                            final mainSubtitle = a.data()['main subtitle'];
                            final mainTitle = a.data()['main title'];
                            final trainerImage = a.data()['trainer image'];
                            final trainerName = a.data()['trainer name'];
                            final payment = a.data()['payment'];
                            final studentEnrolled =
                                a.data()['student enrolled'];
                            final webinarDuration =
                                a.data()['webinar duration'];
                            final mentorImage = a.data()['mentor image'];
                            final aboutMentor = a.data()['about mentor'];

                            if (sDate > 0) {
                              int wbinarTime = sDate;
                              if (course == widget.topic) {
                                Column singleWebinar = Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 15),
                                      alignment: Alignment.center,
                                      color: Colors.blue,
                                      child: Text(supperTitle,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: 1000,
                                      child: Text(
                                        mainTitle,
                                        style: kHeaddingTitle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: 1000,
                                      child: Text(
                                        mainSubtitle,
                                        style: TextStyle(
                                            inherit: false,
                                            fontSize: 20,
                                            color: Color(0xffFF757575),
                                            fontFamily: kfontname,
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    //mentor image and name and login
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Spacer(flex: 3),
                                          Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 550,
                                                    width: 800,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        trainerImage,
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 800,
                                                    height: 70,
                                                    color: Colors.grey[200],
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: Text(
                                                      'With $trainerName',
                                                      style: TextStyle(
                                                          inherit: false,
                                                          fontSize: 30,
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: kfontname,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Spacer(),
                                          // Join and timer
                                          Container(
                                            width: 450,
                                            height: 630,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                // border: Border.all(color: kBlue, width: 3),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      blurRadius: 8,
                                                      offset: Offset(0, 4))
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ///TODO TextField and timer join button
                                                //timer
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 600,
                                                      height: 100,
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            height: 110,
                                                            decoration:
                                                                BoxDecoration(

                                                                    // border: Border.all(
                                                                    //     color: kBlue, width: 3),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          47,
                                                                      child:
                                                                          Stack(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        children: [
                                                                          Positioned(
                                                                            bottom:
                                                                                0,
                                                                            child:
                                                                                SlideCountdownClock(
                                                                              duration: Duration(seconds: wbinarTime),
                                                                              separator: ' : ',
                                                                              textStyle: TextStyle(fontSize: 40, fontFamily: kfontname, color: kBlue),
                                                                              separatorTextStyle: TextStyle(fontSize: 35, color: kBlue),
                                                                              shouldShowDays: true,
                                                                              onDone: () {
                                                                                setState(() {
                                                                                  print(DateTime.now());
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          290,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            'DAYS',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 1),
                                                                          Text(
                                                                            'HRS',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 1),
                                                                          Text(
                                                                            'MIN',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                          SizedBox(
                                                                              width: 1),
                                                                          Text(
                                                                            'SEC',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                fontFamily: kfontname,
                                                                                color: kBlue),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 40,
                                                      child: Text(
                                                        'Webinar Start In...',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      color: Colors.blue,
                                                      width: double.infinity,
                                                    ),
                                                  ],
                                                ),

                                                Form(
                                                  key: _formKey,
                                                  child: Container(
                                                    height: 240,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        _buildName(),
                                                        _buildphonenumber(),
                                                        _buildEmail(),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 0),
                                                  child: MaterialButton(
                                                      child: Text(
                                                        'Join',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      color: kBlue,
                                                      minWidth: double.infinity,
                                                      height: 60,
                                                      elevation: 0,
                                                      hoverElevation: 0,
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          if (name != null &&
                                                              email != null &&
                                                              phoneNumber !=
                                                                  null) {
                                                            _firestore
                                                                .collection(
                                                                    'webinar Users')
                                                                .doc(
                                                                    phoneNumber)
                                                                .set({
                                                              'name': name,
                                                              'email': email,
                                                              'Phone_Number':
                                                                  phoneNumber,
                                                              'payment':
                                                                  payment ==
                                                                          'free'
                                                                      ? 'free'
                                                                      : payment
                                                            });
                                                            _firestore
                                                                .collection(payment ==
                                                                        'free'
                                                                    ? 'free_webinar'
                                                                    : 'paid_webinar')
                                                                .doc(course)
                                                                .update({
                                                              'student enrolled':
                                                                  studentEnrolled +
                                                                      1
                                                            });
                                                          }
                                                          getData();
                                                          nameController
                                                              .clear();
                                                          emailController
                                                              .clear();
                                                          phoneNumberController
                                                              .clear();
                                                        }
                                                      }),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: RichText(
                                                    text: TextSpan(
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[500],
                                                            fontSize: 16),
                                                        text:
                                                            'By clicking the button above, you are creating an account with Ocean Academy and agree to our ',
                                                        children: [
                                                          TextSpan(
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      print(
                                                                          'Privacy Policy taped');
                                                                    },
                                                              text:
                                                                  'Privacy Policy',
                                                              style: TextStyle(
                                                                  color:
                                                                      kBlue)),
                                                          TextSpan(
                                                              text: ' and '),
                                                          TextSpan(
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
                                                                      print(
                                                                          'Terms of Use taped');
                                                                    },
                                                              text:
                                                                  'Terms of Use',
                                                              style: TextStyle(
                                                                  color:
                                                                      kBlue)),
                                                          TextSpan(
                                                              text:
                                                                  ', including receiving emails. '),
                                                        ]),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                          Spacer(flex: 3)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            width: 1000,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.group,
                                                          size: 40,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '$studentEnrolled+',
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              inherit: false,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'STUDENTS ENROLLED',
                                                      style: kContentSubtitle,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                  child: Divider(
                                                    thickness: 60,
                                                    color: Colors.grey[500],
                                                  ),
                                                  width: 3,
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.timer,
                                                          size: 40,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '$webinarDuration Minutes',
                                                          style: TextStyle(
                                                              fontSize: 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              inherit: false,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'MASTERCLASS',
                                                      style: kContentSubtitle,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                  child: Divider(
                                                    thickness: 60,
                                                    color: Colors.grey[500],
                                                  ),
                                                  width: 3,
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .award,
                                                          size: 35,
                                                          color:
                                                              Colors.grey[800],
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          '1,000+',
                                                          style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              inherit: false,
                                                              color: Colors
                                                                  .grey[800]),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      'STORIES ON OCEAN ACADEMY',
                                                      style: kContentSubtitle,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    //Watch The Preview For This Masterclass
                                    Text(
                                      'Watch The Preview For This Webinar',
                                      style: kTitle,
                                    ),
                                    SizedBox(height: 20),
                                    FutureBuilder(
                                      future: _initializeVideoPlayerFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Container(
                                            height: 650,
                                            width: 870,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    AspectRatio(
                                                      aspectRatio:
                                                          _videoController.value
                                                              .aspectRatio,
                                                      child: VideoPlayer(
                                                          _videoController),
                                                    ),
                                                    VideoProgressIndicator(
                                                      _videoController,
                                                      allowScrubbing: true,
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  child: GestureDetector(
                                                    child: Container(
                                                      height: 490,
                                                      width: 870,
                                                      color: Colors.transparent,
                                                    ),
                                                    onTap: () {
                                                      if (_videoController
                                                          .value.isPlaying) {
                                                        _videoController
                                                            .pause();
                                                      } else {
                                                        _videoController.play();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Text('Video Getting');
                                        }
                                      },
                                    ),
                                    SizedBox(height: 40),
                                    Text(
                                      'What You’ll Learn',
                                      style: kTitle,
                                    ),
                                    SizedBox(height: 40),
                                    Column(children: allTopics),

                                    SizedBox(height: 40),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 50),
                                      color: Colors.grey[200],
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'About Mentor',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 50),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                color: Colors.grey[100],
                                                height: 650,
                                                width: 500,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Text(
                                                        aboutMentor,
                                                        style: kContentSubtitle,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 50),
                                              Container(
                                                height: 650,
                                                width: 500,
                                                child: Image(
                                                  image:
                                                      NetworkImage(mentorImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                  ],
                                );
                                wbinars.add(singleWebinar);
                              }
                            }
                          }
                          return Column(children: wbinars);
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
