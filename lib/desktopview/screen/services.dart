import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/card_design.dart';
import 'package:ocean_project/desktopview/Components/image_to_text.dart';
import 'package:ocean_project/desktopview/Components/navigation_bar.dart';
import 'package:ocean_project/desktopview/Components/teext_to_image.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/footer.dart';
import 'package:ocean_project/text.dart';

class Service extends StatefulWidget {
  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNavigationBar(
              title: "Services",
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Our Services',
              style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: kfontname,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 50.0,
            ),
            Center(
              child: Wrap(
                children: [
                  ContainerServiceWidget(),
                  ContainerServiceWidget(),
                  ContainerServiceWidget(),
                  ContainerServiceWidget(),
                  ContainerServiceWidget(),
                  ContainerServiceWidget(),
                ],
              ),
            ),
            ImageToText(
                topic: serviceheading1,
                content: servicecontent1,
                photo: 'images/working.jpg'),
            TextToImage(
              topic: serviceheading2,
              content: servicecontent2,
              photo: 'images/working.jpg',
            ),
            ImageToText(
                topic: serviceheading3,
                content: servicecontent3,
                photo: 'images/working.jpg'),
            TextToImage(
              topic: serviceheading4,
              content: servicecontent4,
              photo: 'images/working.jpg',
            ),
            SizedBox(
              height: 20.0,
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
