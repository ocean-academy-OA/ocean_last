import 'package:flutter/material.dart';

class SliderContent extends ChangeNotifier {
  String title = "", description = "";

  void updateValue(String title, String description) {
    this.title = title;
    this.description = description;
    notifyListeners();
  }
}
