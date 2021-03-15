import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ocean_project/webinar/join_successfully.dart';

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

// getDbData() async {
//   var webinarCollection = await _firestore.collection('Webinar');
//   var webinar = await webinarCollection.get();
//
//   for (var a in webinar.docs) {
//     print(a.id);
//
//     var b = a.data();
//
//     for (var c in b.entries) {
//       print(c.value);
//       var subCollection =
//           await webinarCollection.doc(a.id).collection(c.value).get();
//       for (var d in subCollection.docs) {
//         print(d.data()['payment']);
//       }
//     }
//   }
// }
//
// subscribeDialog(context) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       Future.delayed(Duration(seconds: 3), () {
//         Navigator.pop(context);
//       });
//       return AlertDialog(
//         contentPadding: EdgeInsets.zero,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         backgroundColor: Colors.transparent,
//         content: Container(
//           height: 300,
//           width: 250,
//           decoration: BoxDecoration(
//               color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Thanks for Subscribe',
//                 style: TextStyle(fontSize: 25, color: Colors.grey),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Image.network(
//                   'https://tetranoodle.com/wp-content/uploads/2018/07/tick-gif.gif'),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
//
// List<dynamic> course = ['Python'];
// List<dynamic> courses = ['Flask', 'Python', 'Java'];
//
// courseTest() {
//   for (var i in courses) {
//     if (!course.any((e) => e.contains(i))) {
//       print(i);
//     }
//   }
// }

ScrollController _controller = ScrollController();
final numbrerList = List.generate(50, (index) => index + 1);

showJoinDialog(context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('hi'),
          actions: [
            TextButton(
              child: Text('Join'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => JoinSuccessfully()));
              },
            ),
          ],
        );
      });
}

class _TextingFirebaseState extends State<TextingFirebase> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextButton(
            child: Text('test'),
            onPressed: () async {
              showJoinDialog(context);
              // var time = await _firestore
              //     .collection('webinar_time')
              //     .doc('free_wbinar')
              //     .get();
              // print(
              //   time.data()['timestamp'],
              // );
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => SingleWebinarScreen(
              //               timestamp: time.data()['timestamp'],
              //             )));
            },
          ),
        ),
      ],
    );
  }
}
