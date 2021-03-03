import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/alert/alert_text_field.dart';
import 'package:ocean_project/desktopview/download_pdf/download_alert.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: DownloadPDFAlert(),
    ),
  ));
}

final _firestore = FirebaseFirestore.instance;

class DownloadPDFAlert extends StatefulWidget {
  @override
  _DownloadPDFAlertState createState() => _DownloadPDFAlertState();
}

class _DownloadPDFAlertState extends State<DownloadPDFAlert> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _email = TextEditingController();

  final TextEditingController _otp = TextEditingController();

  bool isEmail = false;
  bool isName = false;
  bool isPhoneNumber = false;
  bool isQuery = false;

  bool isOTP = false;

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

  _downloadAlert({widget, context}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 650,
              width: 1200,
              child: widget,
            ),
          );
        });
  }

  void fireStoreAddWithDownload() {
    _firestore.collection('download pdf').doc().set({
      'name': _name.text,
      'email': _email.text,
      'phonenumber': _mobile.text,
    });
  }

  Widget getUserDetails() {
    bool isEmpty = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 500,
            width: 600,
            child: Image.network(
              'images/download pdf/mail.svg',
              fit: BoxFit.contain,
            )),
        Container(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AlertTextField(
                errorText: 'invalid Name',
                hintText: 'Name',
                icon: Icon(Icons.person),
                controller: _name,
              ),
              AlertTextField(
                hintText: 'Mobile',
                errorText: 'Enter Valid Number',
                icon: Icon(Icons.phone_android),
                controller: _mobile,
              ),
              AlertTextField(
                hintText: 'Email',
                errorText: 'invalid Email',
                icon: Icon(Icons.email),
                controller: _email,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 3),
                        blurRadius: 6)
                  ],
                  color: Colors.white,
                ),
                child: FlatButton(
                  height: 60.0,
                  color: Colors.white,
                  minWidth: 355,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                  child: Row(
                    children: [
                      Container(
                          width: 30,
                          height: 30,
                          child: Image.network(
                              'images/download pdf/mail service.svg')),
                      SizedBox(width: 6),
                      Text(
                        'submit',
                        style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    if (validateEmail(_email.text) &&
                        _mobile.text.length >= 10 &&
                        nameValidation(_name.text) &&
                        _name.text.length > 3) {
                      print('without query field');
                      fireStoreAddWithDownload();
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        isEmpty = false;
                      });
                      Navigator.pop(context);
                      print('fill all field');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget getOTP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 500,
            width: 600,
            child: Image.network(
              'images/download pdf/mail.svg',
              fit: BoxFit.contain,
            )),
        Container(
          child: Column(
            children: [
              AlertTextField(
                errorText: 'invalid OTP',
                hintText: 'Enter OTP',
                icon: Icon(Icons.lock_clock),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Container(
          height: 50,
          width: 300,
          child: TextButton(
            child: Text('Download'),
            onPressed: () async {
              await _downloadAlert(context: context, widget: getUserDetails());
              await _downloadAlert(context: context, widget: getOTP());
              print('ddddddddddddddddd');
            },
          ),
        ),
      ],
    ));
  }
}
