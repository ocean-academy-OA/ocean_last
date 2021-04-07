import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ocean_project/desktopview/constants.dart';
import 'package:ocean_project/desktopview/screen/menubar.dart';
import 'package:provider/provider.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

subscribeDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thanks for Subscribe',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset('images/tick-gif.gif'),
            ],
          ),
        ),
      );
    },
  );
}

subscribeFaildDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Check your Email',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Image.asset('images/wrong-symbol.gif'),
            ],
          ),
        ),
      );
    },
  );
}

class DesktopFooter extends StatefulWidget {
  @override
  _DesktopFooterState createState() => _DesktopFooterState();
}

class _DesktopFooterState extends State<DesktopFooter> {
  TextEditingController _subscribe = TextEditingController();

  void getData() async {
    http.Response response = await http.get(
        'http://free-webinar-registration.herokuapp.com/?name=Brinda&email=${_subscribe.text}&type=subscribe');

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(70.0),
        color: Color(0xFC004478),
        child: Row(
          children: [
            Column(
              children: [],
            ),
            Column(
              children: [],
            ),
            Column(
              children: [],
            ),
            Column(
              children: [],
            ),
          ],
        ));
  }

  MouseRegion footerMouseRegion({text, widget}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            NavbarRouting.menu
                .updateAll((key, value) => NavbarRouting.menu[key] = false);
            NavbarRouting.menu[text] = true;
            print(text);
          });
          Provider.of<Routing>(context, listen: false)
              .updateRouting(widget: widget);
          Provider.of<MenuBar>(context, listen: false)
              .updateMenu(widget: NavbarRouting()
                  // color: text ? Colors.blue : Color(0xFF155575),
                  );
        },
        child: Container(
            child: Text(
          text,
          style: kbottom,
        )),
      ),
    );
  }
}
