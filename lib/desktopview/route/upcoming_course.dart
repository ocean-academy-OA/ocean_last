import 'package:flutter/material.dart';

class UpcomingModel extends ChangeNotifier {
  int flag = 0;

  void updateFlags(int flag) {
    this.flag = flag;
    notifyListeners();
  }
}
