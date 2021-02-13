// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ocean_project/desktopview/Components/map.dart';
import 'package:ocean_project/mobileview/Components/navigation_bar.dart';
import 'package:ocean_project/mobileview/constants.dart';
import 'package:ocean_project/mobileview/screen/footer.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:email_validator/email_validator.dart';
import 'package:ocean_project/text.dart';

final _firestore = FirebaseFirestore.instance;

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final enquiryController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final queryController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // CreateAlertDialog(BuildContext Context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         Future.delayed(Duration(seconds: 2), () {
  //           Navigator.of(context).pop(true);
  //         });
  //         return AlertDialog(
  //           title: Text('Title'),
  //         );
  //       });
  // }

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
      validator: (value) {
        // query = value;
        if (value.isEmpty) {
          print(value);
          return "Query is required*";
        }
        return null;
      },
      maxLines: 13,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Query',
      ),
      controller: queryController,
      onChanged: (value) {
        query = value;
      },
    );
  }

  List<String> enquery = [
    'select',
    'query1',
    'query2',
    'query3',
    'query4',
  ];
  String enquiry = 'select';
  String fullname;
  String email;
  String query;
  String phoneNumber;

  // void getMessage() async {
  //   final message = await _firestore.collection('contact_us').get();
  //   print(message.docs);
  //
  //   for (var courses in message.docs) {
  //     print(courses.data());
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshot in _firestore
  //       .collection('contact_us')
  //       .snapshots(includeMetadataChanges: true)) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

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

  // void _showAlertDialog() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           child: Container(
  //               height: 100,
  //               color: Colors.black,
  //               padding: EdgeInsets.all(10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [Text('ihg')],
  //               )),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
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
                      SizedBox(
                        height: 10,
                      ),
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
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 20),
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
                      RaisedButton(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        splashColor: Colors.white24,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color(0xff0091D2),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: kfontname),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            if (enquiry != null &&
                                fullname != null &&
                                email != null &&
                                query != null &&
                                phoneNumber != null) {
                              _firestore.collection('contact_us').add({
                                'Enquery': enquiry,
                                'Full_Name': fullname,
                                'Email': email,
                                'Query': query,
                                'Phone_Number': phoneNumber
                              });
                              if (enquiry.isNotEmpty) {
                                setState(() {
                                  enquiry = enquery[0];
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Have a snack!'),
                                  ));
                                });
                                print(enquiry);
                              }
                              nameController.clear();
                              emailController.clear();
                              queryController.clear();
                              phoneNumberController.clear();
                            } else {}
                            // If the form is valid, display a Snackbar.
                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(
                            //   SnackBar(
                            //     content: Text('Processing Data'),
                            //   ),
                            // );
                          }
                        },
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
                    height: 370,
                    width: 400,
                    child: getMap(),
                  ),
                  SizedBox(height: 40),
                ],
              ),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
