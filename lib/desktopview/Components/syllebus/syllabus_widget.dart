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
      this.color});
  String title;
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
      color: Colors.white,
      height: 150,
      width: 700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.bottomRight,
                colors: [Color(0xff0B74EF), Color(0xff00D1FF)],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${widget.hourFormat}:${widget.minuteFormat} ${widget.timing}',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
                Column(
                  children: [
                    Text(
                      '${widget.dayFormat}',
                      style: TextStyle(
                          height: 1,
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      '${widget.monthFormatString}',
                      style: TextStyle(
                          fontSize: 20,
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
          Row(
            children: [
              Container(
                width: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.title}',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          inherit: false,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[700]),
                    ),
                    Text(
                      '${widget.subTitle}',
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          inherit: false,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.video_call_sharp),
                iconSize: 35,
                color: widget.color,
                onPressed: widget.onPressed,
              )
            ],
          ),
          Container(
            width: 10,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [Color(0xff0B74EF), Color(0xff00D1FF)],
            )),
          ),
        ],
      ),
    ));
  }
}
