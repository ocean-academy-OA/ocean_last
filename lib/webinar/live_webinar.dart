import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ocean_project/desktopview/Components/ocean_icons.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(body: LiveWebinar()),
  ));
}

class LiveWebinar extends StatelessWidget {
  String linkZoom = "https://oceanacademy.co.in/#/";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xff005D92),
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 8,
                decoration: BoxDecoration(color: Color(0xff0090FF)),
              ),
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 50, right: 10),
                          child: Icon(
                            Ocean.oa,
                            size: 60,
                            color: Colors.blue[200],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            "OCEAN ACADEMEY",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Live",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height:
                          MediaQuery.of(context).size.height > 968 ? 800 : 50,
                      color: Colors.black87,
                      child: IframeScreen(linkZoom),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IframeScreen extends StatefulWidget {
  String src;

  IframeScreen(String _src) {
    this.src = _src;
  }

  @override
  _IframeScreenState createState() => _IframeScreenState(src);
}

class _IframeScreenState extends State<IframeScreen> {
  Widget _iframeWidget;
  final IFrameElement _iframeElement = IFrameElement();
  String _source;

  _IframeScreenState(String _src) {
    _source = _src;
  }

  @override
  void initState() {
    super.initState();
    _iframeElement.src = _source;
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _iframeWidget,
    );
  }
}
