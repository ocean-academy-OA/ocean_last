import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/container_widget.dart';
import 'package:ocean_project/desktopview/Components/navigation_bar.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/footer.dart';

const ktopic = TextStyle(
    fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.normal);
const kcontent = TextStyle(
  fontSize: 20.0,
  color: Colors.black45,
);

// ignore: must_be_immutable
class DesktopAboutUs extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  var myGroup = AutoSizeGroup();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            TopNavigationBar(
              title: "About Us",
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About us Ocean Academy',
                          style: TextStyle(
                            color: Color(0xff0091d2),
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontname,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                            "Computer technology and consultancy firm Ocean Academy, a leading name in the area of IT education, software production and IT services, has graduated more than 5,000 students. The Ocean Academy was built from the outset on the concept of constructing and introducing brilliant innovations that generate change for students and customers. It’s the only location where excellence and technology intersect.",
                            textAlign: TextAlign.justify,
                            style: contentTextStyle),
                        SizedBox(height: 20.0),
                        Text(
                            "In numerous fields, we have allowed digital technologies and are still enabling and fostering the latest technology among students and clients. Students and their lives are also enhancing the quality of learning.",
                            textAlign: TextAlign.justify,
                            style: contentTextStyle),
                        SizedBox(height: 20.0),
                        Text(
                            "We understand the value of the interests of students and consumers and therefore satisfy them with the highest level of service. Improving students' readiness to accept emerging technologies and therefore their ability to go beyond it. We engage in the growth of experts who trust about themselves and are trained with the recent advancements in their particular fields, experts who are competent and willing to succeed in a demanding environment.",
                            textAlign: TextAlign.justify,
                            style: contentTextStyle),
                        SizedBox(height: 20.0),
                        Text(
                            "In 2010, we officially launched our creation of IT trail. It is an entity with a certification of 9001:2008 which will continue to aspire and seek to be creative on all the areas. We are working into a core of excellence to enhance the level of learning and science.",
                            textAlign: TextAlign.justify,
                            style: contentTextStyle),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 300.0,
                              height: 300.0,
                              //height: 300,
                              margin:
                                  EdgeInsets.fromLTRB(120.0, 0.0, 0.0, 50.0),
                              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  image: AssetImage('images/lap.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            Container(
                              width: 300.0,
                              height: 300.0,
                              margin:
                                  EdgeInsets.fromLTRB(20.0, 100.0, 0.0, 20.0),
                              padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                                child: Image(
                                  image: AssetImage('images/lap.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xff0091d2),
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
            SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                Text(
                  "Meet our Mentors",
                  style: TextStyle(
                      color: Color(0xff0091d2),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontname),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Wrap(children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Mentor').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  } else {
                    final messages = snapshot.data.docs;
                    List<ContainerWidget> trainerContent = [];
                    for (var message in messages) {
                      final trainerName = message.data()['name'];
                      final trainerDesignation = message.data()['designation'];
                      final trainerImage = message.data()['image'];
                      final fbLink = message.data()['fbLink'];
                      final gmailLink = message.data()['gmailLink'];
                      final linkedinLink = message.data()['linkedinLink'];
                      final twitter = message.data()['twitter'];

                      final messageContent = ContainerWidget(
                        fbLink: fbLink,
                        gmailLink: gmailLink,
                        linkedinLink: linkedinLink,
                        twitterLink: twitter,
                        designation: trainerDesignation,
                        trainerName: trainerName,
                        image: trainerImage,
                      );
                      trainerContent.add(messageContent);
                      // }
                    }
                    return Wrap(
                      alignment: WrapAlignment.center,
                      children: trainerContent,
                    );
                  }
                },
              ),
            ]),
            Footer(),
          ],
        ),
      ),
    );
  }
}
