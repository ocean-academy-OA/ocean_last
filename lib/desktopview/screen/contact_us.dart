import 'dart:html';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ocean_project/desktopview/Components/navigation_bar.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/text.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:ocean_project/desktopview/screen/footer.dart';

final _firestore = FirebaseFirestore.instance;

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  dynamic getDate() async {
    return DateTime.now();
  }

  void getData() async {
    http.Response response = await http.get(
        """https://us-central1-ocean-live-project-ea2e7.cloudfunctions.net/sendMail?dest=jass07rtr@gmail.com&sub=OA COURSE ENQUIRY - $date $time&html= <!DOCTYPE html>
<html>
<style>
table, th, td {
  border: 1px solid red;
  border-collapse: collapse;
}
</style>
<body>



<table border="outline">
<tbody>

<tr>
<td style="font-weight:bold;width:180px">Enquiry</td>
<td>$enquiry</td>
</tr>

<tr>
<td style="font-weight:bold;width:180px">Full Name</td>
<td>$fullname</td>
</tr>

<tr>
<td style="font-weight:bold;width:180px">Phone Number</td>
<td>$phoneNumber</td>
</tr>

<tr>
<td style="font-weight:bold;width:180px">Email</td>
<td>$email</td>
</tr>

<tr>
<td style="font-weight:bold;width:180px">Query</td>
<td>$query</td>
</tr>

</tbody>
</table>

</body>
</html>""")

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  String linkMaps =
      "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2320.9284365759204!2d79.82874531102095!3d11.952276565466109!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a53616c1e43a73f%3A0xf3758f2502e74f5b!2sOcean%20Academy%20Software%20Training%20Division!5e0!3m2!1sen!2sin!4v1613816776714!5m2!1sen!2sin";
  bool showSpinner = false;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  final enquiryController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final queryController = TextEditingController();
  final phoneNumberController = TextEditingController();

  List<String> enquery = [
    'Select',
    'Enquery1',
    'Enquery2',
    'Enquery3',
    'Enquery4',
    'Enquery5',
    'Enquery6',
  ];

  String enquiry = 'Select';
  String fullname;
  String email;
  String query;
  String phoneNumber;
  var date;
  var time;

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

  Widget _buildName() {
    return TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s")),
        LengthLimitingTextInputFormatter(40),
      ],
      // autovalidate: _autoValidate,
      validator: (value) {
        if (value.isEmpty) {
          return 'name is required';
        } else if (value.length < 3) {
          return 'character should be morethan 2';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.drive_file_rename_outline),
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
        prefixIcon: Icon(Icons.phone_android_outlined),
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
      autovalidate: _autoValidate,
      validator: (value) =>
          EmailValidator.validate(value) ? null : "please enter a valid email",
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        opacity: 0.1,
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopNavigationBar(title: 'Contact Us'),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 150.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.mobileAlt,
                                color: Colors.blue,
                                size: 35,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '0413-2238675',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Ubuntu',
                                  color: kcontentcolor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.blue,
                                size: 35,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'oceanacademy@gmail.com',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Ubuntu',
                                    color: kcontentcolor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 60),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.mapMarkerAlt,
                                color: Colors.blue,
                                size: 35,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'No. 2, Karuvadikuppam Main Rd, '
                                  'near GINGER HOTEL, Senthamarai Nagar, '
                                  'Muthialpet, Puducherry, 605003',
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Ubuntu',
                                    color: kcontentcolor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  height: 400,
                                  width: 450,
                                  child: IframeScreen(500, 400, linkMaps),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 125, top: 100, left: 100),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Contact Form',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff505050),
                                fontSize: 25,
                                fontFamily: kfontname,
                              ),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Text(
                              contactuscontent,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontFamily: 'Ubuntu',
                                color: kcontentcolor,
                              ),
                            ),
                            SizedBox(height: 30),
                            RichText(
                              text: TextSpan(
                                  text: 'This Enquiry is for',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: kfontname,
                                    color: kcontentcolor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ]),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == 'Select') {
                                    return 'enquiry is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 12),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: kfontname,
                                    color: kcontentcolor),
                                value: enquiry,
                                items: getDropdown(),
                                onChanged: (value) {
                                  setState(() {
                                    enquiry = value;
                                  });
                                  print(value);
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                text: 'Full Name',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: kfontname,
                                  color: kcontentcolor,
                                ),
                                children: [
                                  TextSpan(
                                    text: '*',
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: _buildName(),
                            ),
                            SizedBox(height: 25),
                            RichText(
                              text: TextSpan(
                                  text: 'Phone Number',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: kfontname,
                                    color: kcontentcolor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ]),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: _buildphonenumber(),
                            ),
                            SizedBox(height: 25),
                            RichText(
                              text: TextSpan(
                                  text: 'E-mail',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: kfontname,
                                    color: kcontentcolor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ]),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: _buildEmail(),
                            ),
                            SizedBox(height: 25),
                            RichText(
                              text: TextSpan(
                                  text: 'Query',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: kfontname,
                                    color: kcontentcolor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ]),
                            ),
                            SizedBox(height: 25),
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: _buildquery(),
                            ),
                            SizedBox(height: 50),
                            Container(
                              width: 120,
                              height: 53,
                              child: ProgressButton(
                                  color: Color(0xff0091D2),
                                  animationDuration:
                                      Duration(milliseconds: 200),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  strokeWidth: 2,
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: kfontname,
                                    ),
                                  ),
                                  onPressed:
                                      (AnimationController controller) async {
                                    TimeOfDay picked = TimeOfDay.now();
                                    MaterialLocalizations localizations =
                                        MaterialLocalizations.of(context);
                                    time = localizations.formatTimeOfDay(picked,
                                        alwaysUse24HourFormat: false);

                                    date = DateFormat("d-M-y")
                                        .format(DateTime.now());
                                    print('${time} < Current Time >');
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
                                          phoneNumber != null) {
                                        await _firestore
                                            .collection('contact_us')
                                            .add({
                                          'Enquery': enquiry,
                                          'Full_Name': fullname,
                                          'Email': email,
                                          'Query': query,
                                          'Phone_Number': phoneNumber
                                        });
                                        getData();
                                        print("${date} < Date Time >");
                                        if (enquiry.isNotEmpty) {
                                          setState(() {
                                            enquiry = enquery[0];
                                          });
                                        }
                                        nameController.clear();
                                        emailController.clear();
                                        queryController.clear();
                                        phoneNumberController.clear();
                                        if (controller.isCompleted) {
                                          setState(() {
                                            controller.reverse();
                                          });
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  'Sent Successfully',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      ;
                                    }
                                  }),
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
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

class IframeScreen extends StatefulWidget {
  double w;
  double h;
  String src;

  IframeScreen(double _w, double _h, String _src) {
    this.w = _w;
    this.h = _h;
    this.src = _src;
  }

  @override
  _IframeScreenState createState() => _IframeScreenState(w, h, src);
}

class _IframeScreenState extends State<IframeScreen> {
  Widget _iframeWidget;
  final IFrameElement _iframeElement = IFrameElement();
  double _width;
  double _height;
  String _source;

  _IframeScreenState(double _w, double _h, String _src) {
    _width = _w;
    _height = _h;
    _source = _src;
  }

  @override
  void initState() {
    super.initState();
    _iframeElement.src = _source;
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: _iframeWidget,
    );
  }
}
