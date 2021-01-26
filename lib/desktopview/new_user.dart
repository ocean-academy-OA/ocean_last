import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_user_screen/home_page.dart';
import 'new_user_screen/log_in.dart';
import 'new_user_screen/otp.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int x = (prefs.getInt('login') ?? 0);
  Widget screen = x == 0
      ? LogIn()
      : Home(
          userID: OTP.userID,
        );

  Firebase.initializeApp();
  await runApp(MaterialApp(
    supportedLocales: [
      Locale('en'),
    ],
    home: screen,
  ));
}
