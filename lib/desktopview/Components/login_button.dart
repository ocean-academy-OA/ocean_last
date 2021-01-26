import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/course_enrole.dart';
import 'package:ocean_project/desktopview/new_user_screen/log_in.dart';
import 'package:ocean_project/desktopview/new_user_screen/otp.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:provider/provider.dart';

class LogInButton extends StatelessWidget {
  const LogInButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(20.0),
      minWidth: 150.0,
      color: Color(0xFF0091D2),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      onPressed: () {
        Provider.of<Routing>(context, listen: false)
            .updateRouting(widget: LogIn());

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => CoursesView()),
        //);
      },
      child: Text(
        "Log in",
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
