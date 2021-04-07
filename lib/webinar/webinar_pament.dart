import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ocean_project/webinar/join_successfully.dart';
import 'package:ocean_project/webinar/webinar_list.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:http/http.dart' as http;

//conditional import
import 'package:ocean_project/desktopview/Components/UiFake.dart'
    if (dart.library.html) 'dart:ui' as ui;

// ignore: must_be_immutable
class WebinarRazorPayWeb extends StatefulWidget {
  String courseName;
  int amount;
  String mainTitle;
  String trainerName;
  String userName;
  String email;
  String mobileNumber;

  WebinarRazorPayWeb(
      {this.amount,
      this.courseName,
      this.mainTitle,
      this.email,
      this.mobileNumber,
      this.userName,
      this.trainerName});
  @override
  _WebinarRazorPayWebState createState() => _WebinarRazorPayWebState();
}

class _WebinarRazorPayWebState extends State<WebinarRazorPayWeb> {
  var date;

  // TextEditingController duration = TextEditingController();

  void getData() async {
    http.Response response = await http.get(
        'https://free-webinar-registration.herokuapp.com/?name=${widget.userName}&title=${widget.mainTitle}-%20${widget.amount.toString() == 'free' ? 'Free Webinar' : 'Webinar'}&date=$day${dayCalled(day)}%20$month%20$year&time=$hours:$minutes$dayFormat%20to%20$toHours:$toMinutes$toDayFormat%20IST&speaker=${widget.trainerName}(Ex%20-%20Ocean%20Academy)&email=${widget.email}&type=freewebinar');
    print(response);
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  String dayCalled(int day) {
    if (day == 1 || day == 21 || day == 31) {
      return 'st';
    } else if (day == 2 || day == 22) {
      return 'nd';
    } else if (day == 3 || day == 23) {
      return 'rd';
    } else {
      return 'th';
    }
  }

  int year, day, hours, toHours, minutes, toMinutes;
  String month, dayFormat, toDayFormat;

  @override
  void initState() {
    year = WebinarCard.timing[widget.courseName]['Year'];
    day = WebinarCard.timing[widget.courseName]['Day'];
    hours = WebinarCard.timing[widget.courseName]['Hours'];
    toHours = WebinarCard.timing[widget.courseName]['To Hours'];
    minutes = WebinarCard.timing[widget.courseName]['Minutes'];
    toMinutes = WebinarCard.timing[widget.courseName]['To Minutes'];
    month = WebinarCard.timing[widget.courseName]['Month'];
    dayFormat = WebinarCard.timing[widget.courseName]['DayFormat'];
    toDayFormat = WebinarCard.timing[widget.courseName]['To DayFormat'];
    var test = DateTime.now();
    date = (DateFormat("dd-MM-y").format(test));
    print(date);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%&&&&&&&&&&&&&&&&&&&&');
    print(widget.userName);
    print(widget.amount);
    print(widget.email);
    print(widget.courseName);
    print(widget.mobileNumber);
    print(widget.trainerName);
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();
      //Event Listener
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        print('PAYMENT  FAILURE!!!!!!!   ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
          print('PAYMENT FAILURE!!!!!!!');
        } else if (element.data == 'SUCCESS') {
          print('PAYMENT SUCCESSFULL!!!!!!!');
          getData();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      JoinSuccessfully(joinUserName: widget.userName)));
          print('PAYMENT SUCCESSFULL !!!!!!!');
        }
      });

      element.requestFullscreen();

      /// todo amount int.parse(widget.amount)
      // element.height="650px";
      // element
      element.srcdoc = """ <!DOCTYPE html><html>

<meta name="viewport" content="width=device-width, initial-scale=0.5">
<head><title>RazorPay Web Payment</title></head>

<body>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>

       var options = {
         "key": "rzp_live_yI4lHyiI5FRJWt",
          "amount": "${widget.amount * 100}", "currency": "INR",
          "name": "${widget.courseName}",
          "description": "Online Payment Transaction",
          "image": "https://example.com/your_logo",
          "handler": function (response){
             window.parent.postMessage("SUCCESS","*");      //2          
          },
          "prefill": {
             "name": "${widget.userName}",
             "email": "${widget.email}",
             "contact": "${widget.mobileNumber}"
           },
           "notes": {
             "address": "Autofy"
          },
          "modal": {
            "ondismiss": function(){
               //window.parent.postMessage("MODAL_CLOSED","*");   //3
            }
          }
       };
       var rzp1 = new Razorpay(options);  
       window.onload = function(e){  //1 
          rzp1.open();
           e.preventDefault();
       }
     </script>   
<style>
</style>
</body>
</html> """;

      element.style.border = 'none';

      return element;
    });
    return Container(
      height: 670,
      width: 400,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6),
      ]),
      child: HtmlElementView(
        viewType: 'rzp-html',
      ),
    );
  }
}

/// alert
