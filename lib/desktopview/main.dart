import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/route/routing.dart';

import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => SliderContent()),
        ChangeNotifierProvider(create: (context) => UpcomingModel()),
        ChangeNotifierProvider(
          create: (context) => CourseProvide(),
        ),
        ChangeNotifierProvider(create: (context) => SyllabusView()),
        ChangeNotifierProvider(create: (context) => OALive()),
        ChangeNotifierProvider(create: (context) => CourseInfo()),
        ChangeNotifierProvider(create: (context) => UserProfiles()),
        ChangeNotifierProvider(create: (context) => MenuBar()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}
