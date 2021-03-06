import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: TextingFirebase(),
      ),
    ),
  );
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class TextingFirebase extends StatefulWidget {
  @override
  _TextingFirebaseState createState() => _TextingFirebaseState();
}

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
              Image.network(
                  'https://tetranoodle.com/wp-content/uploads/2018/07/tick-gif.gif'),
            ],
          ),
        ),
      );
    },
  );
}

class _TextingFirebaseState extends State<TextingFirebase> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('test'),
        onPressed: () async {
          subscribeDialog(context);
          var webinarCollection = await _firestore.collection('Webinar');
          var webinar = await webinarCollection.get();
          print(webinar.docs);
          for (var a in webinar.docs) {
            print(a.id);

            var b = a.data();
            print(b);
            for (var c in b.entries) {
              var subCollection =
                  await webinarCollection.doc(a.id).collection(c.value).get();
              for (var d in subCollection.docs) {
                print(d.data()['name']);
              }
            }
          }
        },
      ),
    );
  }
}
