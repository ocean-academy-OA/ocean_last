import 'package:country_code_picker/country_codes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ocean_project/desktopview/login_layout/layoutbuilder.dart';
import 'package:ocean_project/desktopview/new_user_screen/otp.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

class LoginXS extends StatefulWidget {
  static ConfirmationResult confirmationResult;
  static String registerNumber;
  @override
  _LoginXSState createState() => _LoginXSState();
}

class _LoginXSState extends State<LoginXS> {
  var userSession;
  bool isNumValid = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  String countryCode;
  List<Map<String, String>> contri = codes;
  bool rememberMe = false;
  // String phoneNumber;

  ConfirmationResult confirmationResult;
  getOTP() async {
    LoginXS.confirmationResult = await auth.signInWithPhoneNumber(
        '${countryCode.toString()} ${LoginLayout.phoneNumberController.text}');
    print("${LoginXS.confirmationResult}LogIn.confirmationResult");
  }

  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    await prefs.setString('user', LoginLayout.phoneNumberController.text);
    print('Otp Submited');
  }

  List getContryCode() {
    List<String> contryCode = [];
    for (var cCode in contri) {
      contryCode.add(cCode['code']);
    }
    return contryCode;
  }

  _launchURL() async {
    try {
      const url = 'https://oceanacademy.in/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.blue,
              // color: Color(0xff2B9DD1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 380.0,
                    height: 320,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    decoration: BoxDecoration(
                        color: Color(0xff006793),
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Container(
                          // color: Colors.grey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.0),
                              Text(
                                'Mobile Number',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40.0,
                                    width: 120,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
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
                                        print(
                                            '${countryCode.toString()}countryCode.toString()');
                                      },

                                      dialogTextStyle:
                                          TextStyle(color: Colors.white),
                                      enabled: true,
                                      boxDecoration: BoxDecoration(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70.0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40.0,
                                          width: 220.0,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(3.0)),
                                          child: TextField(
                                            decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder()),
                                            controller: LoginLayout
                                                .phoneNumberController,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d+\.?\d{0,1}')),
                                              LengthLimitingTextInputFormatter(
                                                  13),
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                LoginLayout.phoneNumber = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Visibility(
                                            visible: isNumValid,
                                            child: Text(
                                              'Enter valid PhoneNumber',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15.0),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0),
                                        width: 300.0,
                                        child: Text(
                                          'NEXT',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      elevation: 0.0,
                                      onPressed: () async {
                                        print(
                                            "${_phoneNumberController.text}_phoneNumberController.text");
                                        setState(() {
                                          //Navbar.visiblity = false;
                                          OTP.userID =
                                              '${countryCode.toString()} ${_phoneNumberController.text}';
                                          // MenuBar.stayUser = OTP.userID;
                                        });

                                        if (_phoneNumberController
                                                .text.length >=
                                            10) {
                                          //getData();

                                          ///todo remove the hide get otp
                                          //session();
                                          getOTP();

                                          Provider.of<Routing>(context,
                                                  listen: false)
                                              .updateRouting(widget: OTP());
                                        } else {
                                          isNumValid = true;
                                        }
                                      }),
                                ],
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 300.0,
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          text:
                                              'By clicking the button above, you are creating an account with Ocean Academy and agree to our ',
                                          children: [
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        print(
                                                            'Privacy Policy taped');
                                                      },
                                                text: 'Privacy Policy',
                                                style: TextStyle(
                                                    color: Colors.cyanAccent)),
                                            TextSpan(text: ' and '),
                                            TextSpan(
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        print(
                                                            'Terms of Use taped');
                                                      },
                                                text: 'Terms of Use',
                                                style: TextStyle(
                                                    color: Colors.cyanAccent)),
                                            TextSpan(
                                                text:
                                                    ', including receiving emails. '),
                                          ]),
                                      textAlign: TextAlign.justify,
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
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    width: 380,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        color: Color(0xff006793),
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Or ',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        TextButton(
                          child: Text(
                            'click here',
                            style: TextStyle(
                                color: Colors.cyanAccent, fontSize: 18.0),
                          ),
                          onPressed: _launchURL,
                        ),
                        Text(
                          ' to visit website',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: -70,
                left: -250.0,
                child: Image.asset(
                  'images/rectangle-01.png',
                  width: 400.0,
                )),
            Positioned(
                top: -70,
                right: 50.0,
                child: Image.asset(
                  'images/tryangle-01.png',
                  width: 200.0,
                )),
            Positioned(
                bottom: 90,
                right: 0.0,
                child: Image.asset(
                  'images/circle-01.png',
                  width: 250.0,
                )),
          ],
        ),
      ),
    );
  }
}
