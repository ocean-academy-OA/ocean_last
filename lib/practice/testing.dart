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

subCollection(QueryDocumentSnapshot) async {}

class _TextingFirebaseState extends State<TextingFirebase> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text('test'),
        onPressed: () async {
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
