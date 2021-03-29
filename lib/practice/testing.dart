import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ocean_project/desktopview/Components/syllebus/syllabus_widget.dart';
import 'package:ocean_project/desktopview/Components/zoom_integration.dart';
import 'package:ocean_project/desktopview/route/routing.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: ViewSyllabus()),
    ),
  );
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ViewSyllabus extends StatefulWidget {
  @override
  _ViewSyllabusState createState() => _ViewSyllabusState();
}

class _ViewSyllabusState extends State<ViewSyllabus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('course')
                .doc('OCNJA18')
                .collection('schedule')
                .orderBy('id')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text('Looding...');
              } else {
                List<SyllabusList> syllabusLists = [];
                Map<int, String> scheduleDocId = {};
                Map<int, Widget> syllabusMap = {};
                List<int> timingList = [];
                timingList.sort();
                for (var i in snapshot.data.docs) {
                  String title = i.id;
                  String subTitle = i.data()['description'];
                  String zoomLink = i.data()['zoom_link'];
                  String zoomPassword = i.data()['zoom_password'];
                  Timestamp timeStamp = i.data()['date'];
                  int coursId = i.data()['id'];

                  int yearFormat;
                  int monthFormat;
                  int dayFormat;
                  int hourFormat;
                  int minuteFormat;
                  int secondsFormat;
                  String monthFormatString;

                  var year = DateFormat('y');
                  var month = DateFormat('MM');
                  var day = DateFormat('d');
                  var hour = DateFormat('hh');
                  var minute = DateFormat('mm');
                  var seconds = DateFormat('s');
                  var monthString = DateFormat('MMMM');

                  yearFormat = int.parse(year.format(timeStamp.toDate()));
                  monthFormat = int.parse(month.format(timeStamp.toDate()));
                  monthFormatString = monthString.format(timeStamp.toDate());
                  dayFormat = int.parse(day.format(timeStamp.toDate()));
                  hourFormat = int.parse(hour.format(timeStamp.toDate()));
                  minuteFormat = int.parse(minute.format(timeStamp.toDate()));
                  secondsFormat = int.parse(seconds.format(timeStamp.toDate()));
                  var timeFormat = DateFormat('a').format(timeStamp.toDate());
                  var defrenceTime = DateTime(
                          yearFormat,
                          monthFormat,
                          dayFormat,
                          timeFormat == 'AM' ? hourFormat : hourFormat + 12,
                          minuteFormat,
                          secondsFormat)
                      .difference(DateTime.now())
                      .inSeconds;

                  SyllabusList syllabusAdd = SyllabusList(
                    title: title,
                    subTitle: subTitle,
                    dayFormat: dayFormat,
                    monthFormatString: monthFormatString,
                    minuteFormat: minuteFormat,
                    hourFormat: hourFormat,
                    color: coursId == 0 ? Color(0xff14BC05) : Color(0xff0B74EF),
                    timing: timeFormat,
                    onPressed: coursId == 1
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ZoomIntegration(
                                          zoomLink:
                                              "https://brindakarthik.github.io/zoom/?meetingNumber=$zoomLink&username=abc&password=$zoomPassword",
                                        )));
                          }
                        : coursId == 0
                            ? () {
                                print('completed');
                              }
                            : null,
                  );
                  syllabusLists.add(syllabusAdd);
                  // timingList.add(defrenceTime);
                  // syllabusMap.addAll({defrenceTime: syllabusAdd});
                  // scheduleDocId.addAll({defrenceTime: i.id});
                  // print(timingList);
                }
                timingList.sort();
                print(timingList);

                // for (var widget in timingList) {
                //   syllabusLists.add(syllabusMap[widget]);
                //   _firestore
                //       .collection('course')
                //       .doc('OCNJA18')
                //       .collection('schedule')
                //       .doc(scheduleDocId[widget])
                //       .update({'flag': true});
                // }

                return SingleChildScrollView(
                  child: Column(
                    children: syllabusLists,
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
//
// class SyllabusList extends StatefulWidget {
//   @override
//   _SyllabusListState createState() => _SyllabusListState();
// }
//
// class _SyllabusListState extends State<SyllabusList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: Container(
//       color: Colors.white,
//       height: 150,
//       width: 700,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             width: 150,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: FractionalOffset.topLeft,
//                 end: FractionalOffset.bottomRight,
//                 colors: [Color(0xff0B74EF), Color(0xff00D1FF)],
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text(
//                   '10:30 AM',
//                   style: TextStyle(
//                       fontSize: 22,
//                       color: Colors.white,
//                       fontWeight: FontWeight.normal),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       '25',
//                       style: TextStyle(
//                           height: 1,
//                           fontSize: 60,
//                           color: Colors.white,
//                           fontWeight: FontWeight.normal),
//                     ),
//                     Text(
//                       'September',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.normal),
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 )
//               ],
//             ),
//           ),
//           Row(
//             children: [
//               Container(
//                 width: 300,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Title',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontFamily: 'Roboto',
//                           inherit: false,
//                           fontWeight: FontWeight.w800,
//                           color: Colors.grey[700]),
//                     ),
//                     Text(
//                       'Subtitle',
//                       style: TextStyle(
//                           fontSize: 18,
//                           fontFamily: 'Roboto',
//                           inherit: false,
//                           fontWeight: FontWeight.normal,
//                           color: Colors.grey[500]),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.video_call_sharp),
//                 iconSize: 35,
//                 color: Color(0xff0B74EF),
//                 onPressed: () {
//                   print('join');
//                 },
//               )
//             ],
//           ),
//           Container(
//             width: 10,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//               begin: FractionalOffset.topLeft,
//               end: FractionalOffset.bottomRight,
//               colors: [Color(0xff0B74EF), Color(0xff00D1FF)],
//             )),
//           ),
//         ],
//       ),
//     )));
//   }
// }

//
// class CountryStatePicker extends StatefulWidget {
//   @override
//   _CountryStatePickerState createState() => _CountryStatePickerState();
// }
//
// class _CountryStatePickerState extends State<CountryStatePicker> {
//   List<String> country = [];
//   final countryContrller = TextEditingController();
//   String selectedCountry = '';
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     for (var i in contryState['countries']) {
//       country.add(i['country']);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Container(
//         alignment: Alignment.center,
//         width: 300,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.white,
//         ),
//         child: DropDownField(
//           controller: countryContrller,
//           hintText: 'search country',
//           enabled: true,
//           strict: false,
//           required: true,
//           itemsVisibleInDropdown: 10,
//           items: country,
//           onValueChanged: (value) {
//             setState(() {
//               selectedCountry = value;
//             });
//           },
//         ),
//       ),
//     ));
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   // List<VagasDisponivei> _vagasDisponiveis;
//   String vaga_name;
//   String selectedValue;
//
//   List<DropdownMenuItem> country = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     for (var i in contryState['countries']) {
//       // country.add(i['country']);
//       country.add(DropdownMenuItem<String>(child: Text('${i['country']}')));
//     }
//     print(country);
//     // print(contryState['countries']);
//     // _vagasDisponiveis = [
//     //   VagasDisponivei(v_id: "1", v_n: "abc"),
//     //   VagasDisponivei(v_id: "2", v_n: "def"),
//     //   VagasDisponivei(v_id: "3", v_n: "dgg"),
//     // ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SearchableDropdown(
//               items: country,
//               isExpanded: true,
//               value: selectedValue,
//               isCaseSensitiveSearch: false,
//               searchHint: new Text(
//                 'Select ',
//                 style: new TextStyle(fontSize: 20),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   selectedValue = value;
//                   print(selectedValue);
//                 });
//               },
//             ),
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: _incrementCounter,
//       //   tooltip: 'Increment',
//       //   child: Icon(Icons.add),
//       // ),
//     );
//   }
// }
//
// FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
// class TextingFirebase extends StatefulWidget {
//   @override
//   _TextingFirebaseState createState() => _TextingFirebaseState();
// }
//
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
//
// final numbrerList = List.generate(50, (index) => index + 1);
//

//
// // payment(List userId) async {
// //   List<Widget> datas = [];
// //   var allpayment = await _firestore
// //       .collection('new users')
// //       .doc(userId[0])
// //       .collection('payment')
// //       .get();
// //   var paymentData = allpayment.docs;
// //   for (var j in paymentData) {
// //     final date = j.data()['date'];
// //     final coursename = j.data()['coursename'];
// //     final amount = j.data()['amount'];
// //     final image = j.data()['image'];
// //     final paid_via = j.data()['paid_via'];
// //     final status = j.data()['status'];
// //     Column singleData = Column(
// //       children: [
// //         Text(date),
// //         Text(coursename),
// //         Text(amount),
// //         Text(image),
// //         Text(paid_via),
// //         Text(status),
// //       ],
// //     );
// //     datas.add(singleData);
// //   }
// //   return Column(children: [Text('hi')]);
// // }
// //
// // Widget paymentStreem(String userId) {
// //   return StreamBuilder<QuerySnapshot>(
// //       stream: _firestore
// //           .collection('new users')
// //           .doc(userId)
// //           .collection('payment')
// //           .snapshots(),
// //       builder: (contex, snapshot) {
// //         if (snapshot.hasData) {
// //           return Text('test...');
// //         } else {
// //           var paymentData = snapshot.data.docs;
// //           for (var j in paymentData) {
// //             final date = j.data()['date'];
// //             final coursename = j.data()['coursename'];
// //             final amount = j.data()['amount'];
// //             final image = j.data()['image'];
// //             final paid_via = j.data()['paid_via'];
// //             final status = j.data()['status'];
// //             print(j.data());
// //           }
// //           return Text('testr..');
// //         }
// //       });
// // }
//
// class _TextingFirebaseState extends State<TextingFirebase> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('new users')
//           .snapshots(includeMetadataChanges: true),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Text('if...');
//         } else {
//           var test = snapshot.data.docs;
//           for (var i in test) {
//             print(i.id);
//           }
//           return Text('222222222');
//         }
//       },
//     );
//   }
// }
