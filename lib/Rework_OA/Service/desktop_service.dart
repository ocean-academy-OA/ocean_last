import 'package:flutter/material.dart';
import 'package:ocean_project/Rework_OA/Service/service_widget/Desktop_widget/card_design.dart';
import 'package:ocean_project/Rework_OA/Service/service_widget/Desktop_widget/image_to_text.dart';
import 'package:ocean_project/Rework_OA/Service/service_widget/Desktop_widget/navigation_bar.dart';
import 'package:ocean_project/Rework_OA/Service/service_widget/Desktop_widget/teext_to_image.dart';

import 'package:ocean_project/desktopview/constants.dart';

class DesktopService extends StatefulWidget {
  @override
  _DesktopServiceState createState() => _DesktopServiceState();
}

class _DesktopServiceState extends State<DesktopService> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  title: 'On-Campus trainin',
                  content:
                      "We offer on-campus learning for students of various Universities and Colleges and help facilitate knowledge and develop their career.",
                  icon: 'images/campus-training.png',
                ),
                ContainerServiceWidget(
                  title: "Software development",
                  content:
                      "We offer various software development services such as designing, planning, and testing and also provide maintenance.",
                  icon: 'images/software devolopment.png',
                ),
                ContainerServiceWidget(
                  title: "Technical Workshops (Implant training)",
                  content:
                      "We devise and plan workshops targeted towards the practical needs of students and exploring new nuances in IT technology.",
                  icon: 'images/technical workshop.png',
                ),
                ContainerServiceWidget(
                  title: "IT consulting",
                  content:
                      "We provide data analysis services to companies, manage their data and infrastructure, and guide them according to their goals and needs using our technologies.",
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
              topic: 'Hone your skills with Corporate Training',
              content:
                  'Corporate Training enables a professional or a skilled jobseeker to improve upon their current skills in areas of expertise required. Ocean Academy provides a professional work place experience and helps equip trainees with the expectations of the corporate world.',
              photo:
                  'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fcorporate%20trining.svg?alt=media&token=73464595-cf57-4c7e-b7c6-5dea4d5009ae'),
          TextToImage(
            topic: 'Start a new career with Career-oriented courses',
            content:
                'Start learning new technologies from scratch and build a solid foundation for your career. Career courses offered by Ocean Academy – a golden opportunity for graduate students – covers the basics of the course up to the level of expertise required.',
            photo:
                'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fcareer%20oriented.svg?alt=media&token=7dcee29f-ecea-4ed4-b4a5-485a90bdc3b2',
          ),
          ImageToText(
              topic:
                  'Experience latest technologies through Workshops & Value-added Courses',
              content:
                  'Workshops are a great means to learn new innovations by further investigation on your own or through the actual methods encouraged by us in a short stretch of time.',
              photo:
                  'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Fworkshops%20and%20value.svg?alt=media&token=6a4cc10d-a9c4-43f0-bf46-f0d6077a8456'),
          TextToImage(
            topic: 'Learn new skills through Software training',
            content:
                'Software training provides the knowledge of technologies that you deem to be necessary for your career or education. This enables learning new product features and ad hoc functions of a known application, improves productivity, and facilitates one to work more independently.',
            photo:
                'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/service%20images%20svgs%2Flearn%20new%20skil.svg?alt=media&token=1d608f76-07dc-48f2-951f-819cee6f0b92',
          ),
          SizedBox(
            height: 20.0,
          ),
          // Footer(),
        ],
      ),
    );
  }
}
