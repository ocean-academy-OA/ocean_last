import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_project/desktopview/screen/career/career_layout.dart';
import 'package:ocean_project/desktopview/screen/footer.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

class CareerSm extends StatefulWidget {
  @override
  _CareerSmState createState() => _CareerSmState();
}

class _CareerSmState extends State<CareerSm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validation = false;
  String email;
  void getData() async {
    http.Response response = await http.get(
        'http://free-webinar-registration.herokuapp.com/?name=Brinda&email=${CareerLayout.emailController.text}&type=subscribe');

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  Widget _buildEmail() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      autovalidate: validation,
      validator: (value) =>
          EmailValidator.validate(value) ? null : "please enter a valid email",
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Email',
        labelText: 'Email',
      ),
      controller: CareerLayout.emailController,
      onChanged: (value) {
        email = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[400],
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.only(top: 20, left: 20),
              //       child: Image.asset("images/coming_soon/Group 10.png"),
              //     )
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: Text(
                          'We are coming with something',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 7),
                        child: Text(
                          'AMAZING',
                          style: TextStyle(
                              fontSize: 40,
                              letterSpacing: 5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'SUBSCRIBE AND STAY UPDATED',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 250,
                              child: _buildEmail(),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 30,
                              ),
                              height: 52,
                              child: FlatButton(
                                color: Colors.blue,
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.send_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _firestore
                                        .collection("subscribed user")
                                        .doc(email)
                                        .set({"Email": email});
                                    setState(() {
                                      validation = false;
                                    });
                                    getData();
                                    subscribeDialog(context);
                                    CareerLayout.emailController.clear();
                                  } else {
                                    setState(() {
                                      validation = true;
                                    });
                                    subscribeFaildDialog(context);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 300,
                        // padding: EdgeInsets.only(left: 50),
                        child: Image.asset(
                          'images/coming_soon/Group 11.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: -50,
            left: -200,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[100],
                height: 200,
                width: 470,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -215,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[200],
                height: 220,
                width: 470,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -100,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[100],
                height: 200,
                width: 470,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinePathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // path.moveTo(250, size.height);
    // path.lineTo(0.0, size.height);
    // path.lineTo(size.width, size.height);
    path.moveTo(250, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(250, 0.0);

    //jaya design
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(130, 0.0);
    // path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
