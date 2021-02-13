import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/new_user_screen/home_page.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/route/slider_content.dart';
import 'package:ocean_project/desktopview/route/upcoming_course.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int x = (prefs.getInt('login') ?? 0);
  Widget screen = x == 0
      ? OceanLive()
      : Home(
          userID: LogIn.registerNumber,
        );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(screen);
}

class OceanLive extends StatefulWidget {
  @override
  _OceanLiveState createState() => _OceanLiveState();
}

class _OceanLiveState extends State<OceanLive> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Routing()),
        ChangeNotifierProvider(create: (context) => Thanks()),
        ChangeNotifierProvider(create: (context) => SliderContent()),
        ChangeNotifierProvider(create: (context) => UpcomingModel()),
        ChangeNotifierProvider(
          create: (context) => CourseProvide(),
        ),
        ChangeNotifierProvider(create: (context) => SyllabusView()),
        ChangeNotifierProvider(create: (context) => OALive()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Gilroy',
        ),
        home: Scaffold(
          body: Consumer<OALive>(
            builder: (context, routing, child) {
              return routing.route;
            },
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
