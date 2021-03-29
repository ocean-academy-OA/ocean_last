import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/new_user_screen/edit_profile.dart';

class SyllabusList extends StatefulWidget {
  SyllabusList(
      {this.title,
      this.subTitle,
      this.dayFormat,
      this.monthFormatString,
      this.onPressed,
      this.hourFormat,
      this.minuteFormat,
      this.timing,
      this.zoomLink,
      this.zoomPassword,
      this.color,
      this.status});
  String title;
  String status;
  Color color = Color(0xff0B74EF);
  String subTitle;
  String zoomLink;
  String zoomPassword;
  int dayFormat;
  int hourFormat;
  int minuteFormat;
  String timing;
  String monthFormatString;
  Function onPressed;
  @override
  _SyllabusListState createState() => _SyllabusListState();
}

class _SyllabusListState extends State<SyllabusList> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 5,
        )
      ]),
      height: 200,
      width: 1300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [Color(0xff0B74EF), Color(0xff00A3FF)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    '${widget.hourFormat}:${widget.minuteFormat} ${widget.timing}',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${widget.dayFormat}',
                      style: TextStyle(
                          height: 0.8,
                          fontSize: 80,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '${widget.monthFormatString}',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Container(
            width: 1000,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 800,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.title}',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Roboto',
                            inherit: false,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[700]),
                      ),
                      Text(
                        '${widget.subTitle}',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            inherit: false,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.video_call_sharp),
                        iconSize: 50,
                        color: widget.color,
                        onPressed: widget.onPressed,
                      ),
                      Text(
                        widget.status,
                        style: TextStyle(
                            fontSize: 20, color: widget.color, height: 1),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 20,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [Color(0xff0B74EF), Color(0xff00A3FF)],
            )),
          ),
        ],
      ),
    ));
  }
}
