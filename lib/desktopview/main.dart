import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(OceanLive());
}

class OceanLive extends StatefulWidget {
  @override
  _OceanLiveState createState() => _OceanLiveState();
}

class _OceanLiveState extends State<OceanLive> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Routing(),
        child: MaterialApp(
          home: Navbar(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
