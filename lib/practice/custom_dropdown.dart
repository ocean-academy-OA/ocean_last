import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String text;

  const CustomDropDown({Key key, this.text}) : super(key: key);
  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  GlobalKey actionKey;
  bool isDropdown = false;
  double height, width, xPosition, yPosition;
  OverlayEntry floatingDropdown;
  List dropdownItems = [1, 2, 3, 4];
  double triangleHeight = 40;
  OverlayEntry dismis;

  findDropDownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                floatingDropdown.remove();
                isDropdown = !isDropdown;
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              left: xPosition,
              width: width,
              top: height + yPosition,
              // height: 4 * height + triangleHeight,
              child: MyDropDown(
                itemHeight: height,
                onTap: () {
                  floatingDropdown.remove();
                  isDropdown = !isDropdown;
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    actionKey = LabeledGlobalKey(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        isDropdown = !isDropdown;

        if (isDropdown) {
          findDropDownData();
          floatingDropdown = _createFloatingDropdown();
          Overlay.of(context).insert(floatingDropdown);
          print(actionKey.currentState);
        } else {
          floatingDropdown.remove();
          print(actionKey.currentState);
        }

        // print(isDropdown);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.red.shade300,
        height: 50,
        width: 300,
        child: Row(
          children: [
            Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down_sharp,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class MyDropDown extends StatelessWidget {
  MyDropDown({this.itemHeight, this.onTap});
  double itemHeight;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Align(
          alignment: Alignment(-0.8, 10),
          child: ClipPath(
            clipper: ArrowCliper(),
            child: Container(
              height: 20,
              width: 20,
              color: Colors.grey[700],
            ),
          ),
        ),
        Container(
          // height: 4 * itemHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropDownItemC.first(
                  title: 'Add New',
                  iconData: Icons.add,
                  isSelected: false,
                  onTap: onTap,
                ),
                DropDownItemC(
                    title: 'Add New',
                    iconData: Icons.add,
                    isSelected: true,
                    onTap: onTap),
                DropDownItemC(
                    title: 'Add New',
                    iconData: Icons.add,
                    isSelected: false,
                    onTap: onTap),
                DropDownItemC.last(
                    title: 'Add New',
                    iconData: Icons.add,
                    isSelected: false,
                    onTap: onTap),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DropDownItemC extends StatelessWidget {
  final String title;
  final IconData iconData;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;
  final Function onTap;

  const DropDownItemC({
    Key key,
    this.title,
    this.iconData,
    this.onTap,
    this.isSelected = false,
    this.isFirstItem = false,
    this.isLastItem = false,
  }) : super(key: key);
  factory DropDownItemC.first(
      {String title,
      IconData iconData,
      bool isSelected,
      bool isFirstItem,
      Function onTap}) {
    return DropDownItemC(
      title: title,
      iconData: iconData,
      onTap: onTap,
      isSelected: isSelected,
      isFirstItem: true,
    );
  }
  factory DropDownItemC.last(
      {String title,
      IconData iconData,
      bool isSelected,
      bool isLastItem,
      Function onTap}) {
    return DropDownItemC(
      title: title,
      iconData: iconData,
      onTap: onTap,
      isSelected: isSelected,
      isLastItem: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 10,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: isSelected ? Colors.grey[900] : Colors.grey[700],
            borderRadius: BorderRadius.vertical(
                top: isFirstItem ? Radius.circular(10) : Radius.zero,
                bottom: isLastItem ? Radius.circular(10) : Radius.zero)),
        height: 50,
        width: 300,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Icon(
                iconData,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ArrowCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
