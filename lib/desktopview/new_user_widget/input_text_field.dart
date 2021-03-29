import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LableWithTextField extends StatelessWidget {
  static bool readOnly = false;
  LableWithTextField(
      {@required this.lableText,
      @required this.onChanged,
      this.width,
      this.controller,
      this.validator,
      this.inputFormatters,
      this.color = Colors.white,
      this.visible = false,
      this.errorText = 'Invalid Field',
      this.rReadOnly = false});

  final String lableText;
  final Color color;
  final double width;
  final Function validator;
  final Function onChanged;
  final controller;
  final inputFormatters;
  final bool visible;
  final String errorText;
  final bool rReadOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              lableText,
              style: TextStyle(fontSize: 20.0, color: color),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0), color: Colors.white),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  inputFormatters: inputFormatters,
                  readOnly: rReadOnly,
                  validator: validator,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  controller: controller,
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                  onChanged: onChanged,
                ),
                Visibility(
                  visible: visible,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      errorText,
                      style: TextStyle(color: Colors.red[900], fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
