import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/Rework_OA/Service/desktop_service.dart';

import 'Rework_OA/Service/tab_service.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: TabService(),
    ),
  ));
}
