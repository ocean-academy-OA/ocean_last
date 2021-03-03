import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_project/desktopview/new_user_widget/otp_inputs.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:ocean_project/alert/alert_msg.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/new_user_screen/registration.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/course_details.dart';
import 'package:ocean_project/desktopview/screen/courses.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;

class CoursesWidget extends StatefulWidget {
  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
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
      children: [
        (Course.isSelected[0] == true)
            ? StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('offline_course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<OfflineCourse> offlineCourse = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageDuration = message.data()['duration'];
                      final messagePdflink = message.data()['pdflink'];
                      final messageImage = message.data()['img'];

                      final messageCourse = OfflineCourse(
                        trainername: messageText,
                        coursename: messageSender,
                        duration: messageDuration,
                        pdflink: messagePdflink,
                        image: messageImage,
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
            : StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('course').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;

                    List<OnlineCourse> messageBubbles = [];
                    for (var message in messages) {
                      final messageText = message.data()['trainername'];
                      final messageSender = message.data()['coursename'];
                      final messageDuration = message.data()['duration'];
                      final messageTime = message.data()['time'];
                      final messageDate = message.data()['date'];
                      final messageImage = message.data()['img'];
                      final messageDescription =
                          message.data()['coursedescription'];
                      final messageBatchid = message.data()['batchid'];
                      final messageBubble = OnlineCourse(
                        trainername: messageText,
                        coursename: messageSender,
                        duration: messageDuration,
                        time: messageTime,
                        date: messageDate,
                        image: messageImage,
                        description: messageDescription,
                        batchid: messageBatchid,
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
              ),
      ],
    );
  }
}

class OnlineCourse extends StatefulWidget {
  static bool visiblity = false;
  static String syllabusId;
  OnlineCourse(
      {this.coursename,
      this.trainername,
      this.duration,
      this.time,
      this.date,
      this.image,
      this.description,
      this.batchid});
  final String coursename;
  final String trainername;
  final String duration;
  final String time;
  final String image;
  final String description;
  final String batchid;
  final String date;

  @override
  _OnlineCourseState createState() => _OnlineCourseState();
}

class _OnlineCourseState extends State<OnlineCourse> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //studentId();
        print("${OnlineCourse.syllabusId}");
        print("${widget.coursename}jayalatha");
        print("jaya");
        setState(() {
          OnlineCourse.visiblity = true;
        });

        print(widget.coursename);
        Provider.of<Routing>(context, listen: false).updateRouting(
            widget: CourseDetails(
          batch: widget.batchid,
          course: widget.coursename,
          trainer: widget.trainername,
          sess: widget.time,
          desc: widget.description,
        ));
      },
      child: Container(
        margin: EdgeInsets.all(35.0),
        //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        height: 330.0,
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
            Container(
              height: 200,
              width: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
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
                        fontSize: 20.0,
                        color: Colors.grey[600],
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.normal),
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
                      Text(
                        "${widget.duration} hr",
                        style: otherSmallContentTextStyle,
                      ),
                      Icon(
                        Icons.web_sharp,
                        color: Color(0xff3B7EB6),
                      ),
                      Text(
                        "${widget.date}",
                        style: otherSmallContentTextStyle,
                      ),
                      Icon(
                        Icons.video_call,
                        color: Color(0xff3B7EB6),
                      ),
                      Text(
                        "${widget.time} P.M",
                        style: otherSmallContentTextStyle,
                      ),
                      // Text(
                      //   "Click Here",
                      //   style: TextStyle(
                      //       color: Color(0xff3B7EB6),
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: kfontname),
                      // ),
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

class OfflineCourse extends StatefulWidget {
  static String userID;
  OfflineCourse({
    this.coursename,
    this.trainername,
    this.duration,
    this.pdflink,
    this.image,
  });
  final String coursename;
  final String trainername;
  final String duration;
  final String pdflink;
  final String image;

  @override
  _OfflineCourseState createState() => _OfflineCourseState();
}

class _OfflineCourseState extends State<OfflineCourse> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String otp;
  TextEditingController _otp = TextEditingController();
  UserCredential userCredential;
  String count;
  bool isLogin = false;
  _clickHere() async {
    try {
      const url = 'https://flutter.dev';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> otpCount(int count) {
    List<Widget> otp = [];
    for (int i = 0; i < count; i++) {
      otp.add(OTPInput());
    }
    otp.insert(0, SizedBox(width: 5));
    int lis = otp.length;
    otp.insert(lis, SizedBox(width: 5));
    return otp;
  }

  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    await prefs.setString('user', LogIn.registerNumber);
    print('Otp Submited');
  }

  _verifyPhone() async {
    try {
      setState(() {
        // Navbar.visiblity = false;
      });
      userCredential = await LogIn.confirmationResult.confirm(_otp.text);

      OfflineCourse.userID = LogIn.confirmationResult.toString();
      OfflineCourse.userID = LogIn.registerNumber;
      print('${OfflineCourse.userID} ppppppppppppppppppp');
      userSession = await _firestore
          .collection('new users')
          .doc(OfflineCourse.userID)
          .get();

      if (userSession.data() != null) {
        setState(() {
          isLogin = true;
        });

        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => CoursesView()));
        Provider.of<OALive>(context, listen: false)
            .updateOA(routing: CoursesView());

        print('Otp.................got');

        //CoursesView() insted of Home,

        session();
      } else {
        Provider.of<Routing>(context, listen: false)
            .updateRouting(widget: Registration());
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'OTP Invalid',
            style: TextStyle(fontSize: 30.0),
          ),
        ],
      )));
    }
  }

  var userSession;
  getData() async {
    print(userSession.data() != null);
  }

  //////////////////////

  String phoneNumber;
  bool isNumValid = false;
  //FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController _phoneNumberController = TextEditingController();
  String countryCode;
  List<Map<String, String>> contri = codes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //studentId();
  }

  List getContryCode() {
    List<String> contryCode = [];
    for (var cCode in contri) {
      contryCode.add(cCode['code']);
    }
    return contryCode;
  }

  getOTP() async {
    LogIn.confirmationResult = await auth.signInWithPhoneNumber(
        '${countryCode.toString()} ${_phoneNumberController.text}');
  }

  Future<void> _showOtp() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context1) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Color(0xff2B9DD1),
          content: Container(
            color: Color(0xff2B9DD1),
            width: double.infinity,
            height: 500,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 600.0,
                    height: 500.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
                    decoration: BoxDecoration(
                        color: Color(0xff006793),
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 55.0,
                                    width: 450,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                    child: OTPTextField(
                                      length: 6,
                                      width: MediaQuery.of(context).size.width,
                                      textFieldAlignment:
                                          MainAxisAlignment.spaceAround,
                                      fieldWidth: 50,
                                      onChanged: (value) {
                                        print(value);
                                      },
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onCompleted: (value) {
                                        _otp.text = value;
                                      },
                                    ),
                                  ),
                                ],
                                // children: otpCount(6),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Countdown(
                                    seconds: 600,
                                    build:
                                        (BuildContext context, double time) =>
                                            Text(
                                      '${(time ~/ 60).toString().length == 1 ? "0" + (time ~/ 60).toString() : (time ~/ 60)} : ${(time % 60).toString().length == 1 ? "0" + (time % 60).toString() : (time % 60)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23.0,
                                      ),
                                    ),
                                    onFinished: () {},
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                  )
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RawMaterialButton(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff014965),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                      width: 450.0,
                                      child: Text(
                                        'NEXT',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    elevation: 0.0,
                                    onPressed: () async {
                                      _verifyPhone();
                                    },
                                  ),
                                ],
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MaterialButton(
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: Color(0xff006793),
                                      size: 35.0,
                                    ),
                                    color: Colors.white,
                                    minWidth: 70.0,
                                    height: 70.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(70.0)),
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                      _showDialog();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("jaya"),
          content: Container(
            width: 600.0,
            height: 450.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            decoration: BoxDecoration(
                color: Color(0xff006793),
                borderRadius: BorderRadius.circular(6.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Mobile Number',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50.0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3.0)),
                            child: CountryCodePicker(
                              backgroundColor: Colors.transparent,
                              onChanged: print,
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: getContryCode()[
                                  getContryCode().indexOf('IN')],
                              countryFilter: getContryCode(),
                              showFlagDialog: true,
                              showDropDownButton: true,
                              hideSearch: true,
                              dialogSize: Size(300.0, 550.0),
                              onInit: (code) {
                                countryCode = '+91';
                                print('${countryCode.toString()}');
                              },

                              dialogTextStyle: TextStyle(color: Colors.white),
                              enabled: true,
                              boxDecoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Container(
                            height: 70.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50.0,
                                  width: 400.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder()),
                                    controller: _phoneNumberController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,1}')),
                                      LengthLimitingTextInputFormatter(13),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        phoneNumber = value;
                                      });
                                    },
                                  ),
                                ),
                                Visibility(
                                    visible: isNumValid,
                                    child: Text(
                                      'Enter valid PhoneNumber',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15.0),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff014965),
                                    borderRadius: BorderRadius.circular(5.0)),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 15.0),
                                width: 450.0,
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              elevation: 0.0,
                              onPressed: () {
                                Navigator.pop(context);
                                _showOtp();
// print(
//     "${_phoneNumberController.text}phonemunber");
// setState(() {
//   //Navbar.visiblity = false;
//   LogIn.registerNumber =
//       '${countryCode.toString()} ${_phoneNumberController.text}';
//   OALive.stayUser = LogIn.registerNumber;
// });
//
// if (_phoneNumberController.text.length >=
//     10) {
//
//   ///todo remove the hide get otp
//
//   //getOTP()
// } else {
//   isNumValid = true;
//
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final _email = TextEditingController();
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  //mainAxisAli gnment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Color(0xff3B7EB6),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text("${widget.duration} duration"),
                    SizedBox(
                      width: 30.0,
                    ),
                    MaterialButton(
                      padding: EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(05.0))),
                      onPressed: () {
                        _showDialog();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.download_sharp,
                            color: Color(0xff3B7EB6),
                            size: 20.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Download pdf",
                          ),
                        ],
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

  //alert starts from here..
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      //this means the user must tap a button to exit the Alert Dialog
      builder: (BuildContext context) {
        return AlertEnquiry(
          queryField: false,
          buttonName: 'download',
          pdfLink: widget.pdflink,
        );
      },
    );
  }

  bool isEmail = false;
  bool isName = false;
  bool isPhonenumber = false;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool nameValidation(String value) {
    Pattern pattern = r"[a-zA-Z]+|\s";
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool phoneNumberValidation(String value) {
    Pattern pattern = r'^\d+\.?\d{0,2}';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool formValidation() {
    bool ifval = false;
    bool elseval = true;
    if (!nameValidation(_name.text) || _name.text.length < 3) {
      setState(() {
        isName = true;
        ifval = isName;
      });
    } else {
      setState(() {
        isName = false;
        elseval = isName;
      });
    }
    if (!validateEmail(_email.text)) {
      setState(() {
        isEmail = true;
        ifval = isEmail;
      });
    } else {
      setState(() {
        isEmail = false;
        elseval = isEmail;
      });
    }
    if (_mobile.text.length < 6) {
      setState(() {
        isPhonenumber = true;
        ifval = isPhonenumber;
      });
    } else {
      setState(() {
        isPhonenumber = false;
        elseval = isPhonenumber;
      });
    }
    return ifval == elseval;
  }
}
