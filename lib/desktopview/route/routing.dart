import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/Components/enroll_new.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/screen/home_screen.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class Routing extends ChangeNotifier {
  Widget route = Home();

  void updateRouting({Widget widget}) {
    route = widget;
    notifyListeners();
  }
}

class CourseProvide extends ChangeNotifier {
  String courseName;
  void updateCourseName({String course}) {
    courseName = course;
    notifyListeners();
  }
}

class SyllabusView extends ChangeNotifier {
  Widget routing = EnrollNew();
  void updateCourseSyllabus({Widget routing}) {
    this.routing = routing;
    notifyListeners();
  }
}

class OALive extends ChangeNotifier {
  Widget route = Navbar();

  static String stayUser;

  void updateOA({Widget routing}) {
    this.route = routing;
    notifyListeners();
  }
}

class UserProfiles extends ChangeNotifier {
  Widget route = Navbar();

  void updateOA({Widget routing}) {
    this.route = routing;
    notifyListeners();
  }
}

class SliderContent extends ChangeNotifier {
  String title = "", description = "";

  void updateValue(String title, String description) {
    this.title = title;
    this.description = description;
    notifyListeners();
  }
}

class UpcomingModel extends ChangeNotifier {
  int flag = 0;

  void updateFlags(int flag) {
    this.flag = flag;
    notifyListeners();
  }
}
