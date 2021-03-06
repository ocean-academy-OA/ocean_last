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
                  ContainerServiceWidget(
                    title: ourservicesheading1,
                    content: ourservices1,
                    icon: 'images/campus-training.png',
                  ),
                  ContainerServiceWidget(
                    title: ourservicesheading2,
                    content: ourservices2,
                    icon: 'images/software devolopment.png',
                  ),
                  ContainerServiceWidget(
                    title: ourservicesheading3,
                    content: ourservices3,
                    icon: 'images/technical workshop.png',
                  ),
                  ContainerServiceWidget(
                    title: ourservicesheading4,
                    content: ourservices4,
                    icon: 'images/counseling.png',
                  ),
                  ContainerServiceWidget(
                    title: "Title",
                    content: "Subtitle",
                    icon: '',
                  ),
                  ContainerServiceWidget(
                    title: "Title",
                    content: "Subtitle",
                    icon: '',
                  ),
                ],
              ),
            ),
            ImageToText(
                topic: serviceheading1,
                content: servicecontent1,
                photo: 'images/service images/corporate trining.svg'),
            TextToImage(
              topic: serviceheading2,
              content: servicecontent2,
              photo: 'images/service images/career oriented.svg',
            ),
            ImageToText(
                topic: serviceheading3,
                content: servicecontent3,
                photo: 'images/service images/workshops and value.svg'),
            TextToImage(
              topic: serviceheading4,
              content: servicecontent4,
              photo: 'images/service images/learn new skil.svg',
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
