import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: DownloadPDFAlert(),
    ),
  ));
}

class DownloadPDFAlert extends StatefulWidget {
  @override
  _DownloadPDFAlertState createState() => _DownloadPDFAlertState();
}

class _DownloadPDFAlertState extends State<DownloadPDFAlert> {
  _downloadAlert({widget, context}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 650,
              width: 1200,
              child: widget,
            ),
          );
        });
  }

  Widget getUserDetails() {
    return Row(
      children: [
        Column(
          children: [
            Container(
                height: 400,
                width: 500,
                child: Image.network(
                  'images/download pdf/mail.svg',
                  fit: BoxFit.contain,
                )),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 50,
      width: 300,
      child: TextButton(
        child: Text('Download'),
        onPressed: () {
          _downloadAlert(widget: getUserDetails(), context: context);
        },
      ),
    ));
  }
}
