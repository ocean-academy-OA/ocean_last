import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_project/desktopview/Components/comment.dart';
import 'package:ocean_project/desktopview/Components/main_title_widget.dart';
import 'package:ocean_project/text.dart';

class OurClient extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MainTitleWidget(
                title: "Our Clients",
              ),
              SizedBox(
                height: 40.0,
              ),
              TextWidget(
                title: clientcontent,
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
          Wrap(
            spacing: 60.0,
            runSpacing: 100.0,
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('clients').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading.....");
                  } else {
                    final messages = snapshot.data.docs;
                    List<CollegeLogo> collegeLogo = [];

                    for (var message in messages) {
                      final logoImage = message.data()['img'];
                      final logos = CollegeLogo(
                        collegeLogoImage: logoImage,
                      );
                      // Text('$messageText from $messageSender');
                      collegeLogo.add(logos);
                    }
                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 100.0,
                      children: collegeLogo,
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}

class CollegeLogo extends StatelessWidget {
  final String collegeLogoImage;
  CollegeLogo({this.collegeLogoImage});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage("$collegeLogoImage,"),
      width: 200.0,
    );
  }
}
