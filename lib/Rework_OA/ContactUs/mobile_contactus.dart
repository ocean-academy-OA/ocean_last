// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ocean_project/Rework_OA/ContactUs/iframe_map.dart';
import 'package:ocean_project/mobileview/Components/navigation_bar.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/mobileview/screen/footer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ocean_project/text.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:random_string/random_string.dart';

final _firestore = FirebaseFirestore.instance;

class MobileContactUs extends StatefulWidget {
  @override
  _MobileContactUsState createState() => _MobileContactUsState();
}

class _MobileContactUsState extends State<MobileContactUs> {
  List<String> enquery = [
    'Select',
    'Enquery1',
    'Enquery2',
    'Enquery3',
    'Enquery4',
  ];

  String enquiry = 'Select';
  String fullname;
  String email;
  String query;
  String phoneNumber;
  var date;
  var time;
  String firstInt;
  String secondInt;
  int answer;
  String total;
  bool validation = false;
  bool showSpinner = false;

  final enquiryController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final queryController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final answerController = TextEditingController();

  dynamic getDate() async {
    return DateTime.now();
  }

  void getData() async {
    http.Response response = await http.get(
        """https://shrouded-fjord-03855.herokuapp.com/?name=$fullname&des=$query&mobile=$phoneNumber&email=$email&date=$date $time &type=$enquiry""");

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  String linkMaps =
      "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2320.9284365759204!2d79.82874531102095!3d11.952276565466109!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a53616c1e43a73f%3A0xf3758f2502e74f5b!2sOcean%20Academy%20Software%20Training%20Division!5e0!3m2!1sen!2sin!4v1613816776714!5m2!1sen!2sin";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(40),
      ],
      validator: (value) {
        if (value.isEmpty) {
          return 'Name is required*';
        } else if (value.length < 3) {
          return 'character should be morethan 3*';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Name',
        labelText: 'Name',
      ),
      controller: nameController,
      onChanged: (value) {
        fullname = value;
      },
    );
  }

  Widget _buildphonenumber() {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"^\d+\.?\d{0,2}")),
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value.isEmpty) {
          return 'phone_number is required*';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Number',
        labelText: 'Number',
      ),
      controller: phoneNumberController,
      onChanged: (value) {
        phoneNumber = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      validator: (value) =>
          EmailValidator.validate(value) ? null : "invalid email",
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
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

  Widget _buildquery() {
    return TextFormField(
      autovalidate: validation,
      validator: (value) {
        // query = value;
        if (value.isEmpty) {
          print(value);
          return "query is required";
        } else if (value.length < 2) {
          return 'character should be more than 2';
        }
        return null;
      },
      maxLines: null,
      maxLength: 1000,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.question_answer_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Query',
        labelText: 'Query',
      ),
      controller: queryController,
      onChanged: (value) {
        query = value;
      },
    );
  }

  Widget _buildAnswerField() {
    return TextFormField(
      autovalidate: validation,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(
          RegExp(r"^\d+\.?\d{0,2}"),
        ),
        LengthLimitingTextInputFormatter(2),
      ],
      validator: (value) {
        if (answer.toString() != total) {
          return 'wrong';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        // prefixIcon: Icon(Icons.phone_android_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 0),
        border: OutlineInputBorder(),
        // hintText: 'Enter Your Number',
        // labelText: 'Number',
      ),
      controller: answerController,
      onChanged: (value) {
        total = value;
      },
    );
  }

  List getDropdown() {
    List<DropdownMenuItem<String>> dropList = [];

    for (var enquerys in enquery) {
      var newList = DropdownMenuItem(
        child: Text(enquerys),
        value: enquerys,
      );
      dropList.add(newList);
    }
    return dropList;
  }

  calc() {
    var first = int.parse(firstInt);
    var second = int.parse(secondInt);
    answer = first + second;

    print("$firstInt  //////////////////firstInt");
    print("$secondInt  //////////////////secondInt");
    print("$answer  //////////////////answer");
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      opacity: 0.1,
      inAsyncCall: showSpinner,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopNavigationBar(
              title: 'Contact Us',
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.mobileAlt,
                        color: Colors.blue,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        '0413-2238675',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: kfontname,
                          color: kcontentcolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.blue,
                        size: 40,
                      ),
                      Text(
                        'oceanacademy@gmail.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: kfontname,
                          color: kcontentcolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.blue,
                        size: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No. 2, Karuvadikuppam Main Rd, '
                        'near GINGER HOTEL, Senthamarai Nagar, '
                        'Muthialpet, Puducherry, 605003',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontFamily: kfontname,
                          color: kcontentcolor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Contact Form',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff505050),
                          fontSize: 20,
                          fontFamily: kfontname),
                    ),
                    SizedBox(height: 10),
                    Text(
                      contactuscontent,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: kfontname,
                          color: kcontentcolor,
                          height: 1.5),
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'This Enquiry is for',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: kfontname,
                            color: kcontentcolor,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: DropdownButton<String>(
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: kfontname,
                              color: kcontentcolor,
                            ),
                            value: enquiry,
                            isExpanded: true,
                            items: getDropdown(),
                            onChanged: (value) {
                              setState(() {
                                enquiry = value;
                              });
                              print(value);
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Full Name',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: kfontname,
                            color: kcontentcolor,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildName(),
                        SizedBox(height: 30),
                        Text(
                          'Phone Number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: kfontname,
                            color: kcontentcolor,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildphonenumber(),
                        SizedBox(height: 30),
                        Text(
                          'E-mail Address',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: kfontname,
                            color: kcontentcolor,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildEmail(),
                        SizedBox(height: 30),
                        Text(
                          'Your Query',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: kfontname,
                            color: kcontentcolor,
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildquery(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "I'm not Robot",
                            style: TextStyle(
                              color: Colors.grey[600],
                              letterSpacing: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[100],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 30,
                                    child: Text(
                                      firstInt =
                                          randomBetween(1, 10).toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 30,
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 30,
                                    child: Text(
                                      secondInt =
                                          randomBetween(1, 10).toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 30,
                                    child: Text(
                                      '=',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 30,
                                    color: Colors.white,
                                    child: _buildAnswerField(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      width: 100,
                      height: 40,
                      child: ProgressButton(
                          color: Color(0xff0091D2),
                          animationDuration: Duration(milliseconds: 200),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          strokeWidth: 2,
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: kfontname,
                            ),
                          ),
                          onPressed: (AnimationController controller) async {
                            calc();
                            print(answerController.text);

                            TimeOfDay picked = TimeOfDay.now();
                            MaterialLocalizations localizations =
                                MaterialLocalizations.of(context);
                            time = localizations.formatTimeOfDay(picked,
                                alwaysUse24HourFormat: false);

                            date = DateFormat("d-M-y").format(DateTime.now());
                            print('$time < Current Time >');
                            if (_formKey.currentState.validate()) {
                              if (controller.isCompleted) {
                                controller.reverse();
                              } else {
                                controller.forward();
                              }
                              _formKey.currentState.save();
                              if (enquiry != null &&
                                  fullname != null &&
                                  email != null &&
                                  query != null &&
                                  phoneNumber != null &&
                                  answer.toString() == total) {
                                await _firestore.collection('contact_us').add({
                                  'Enquery': enquiry,
                                  'Full_Name': fullname,
                                  'Email': email,
                                  'Query': query,
                                  'Phone_Number': phoneNumber
                                });
                                // getData();
                                print("$date < Date Time >");
                                setState(() {
                                  print(
                                      'working////////////////////////////////////');
                                  validation = false;
                                });
                                if (enquiry.isNotEmpty) {
                                  setState(() {
                                    enquiry = enquery[0];
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Your enquiry sent successfully!')));
                                  });
                                }
                                nameController.clear();
                                emailController.clear();
                                queryController.clear();
                                phoneNumberController.clear();
                                answerController.clear();

                                if (controller.isCompleted) {
                                  setState(() {
                                    controller.reverse();
                                  });
                                }
                              }
                            } else {
                              setState(() {
                                print(
                                    'working////////////////////////////////////');
                                validation = true;
                              });
                            }
                          }),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 300,
                  width: 400,
                  child: IframeScreen(400, 300, linkMaps),
                ),
                SizedBox(height: 40),
              ],
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
