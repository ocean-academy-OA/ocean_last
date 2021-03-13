import 'package:flutter/material.dart';

void main() {
  runApp(Portfolio());
}

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  ScrollController _scrollController;
  String _curNavItem;

  static double offsetHome = 0;
  static double offsetAbout = SizeConfig.screenHeight;
  static double offsetBlog = 2 * SizeConfig.screenHeight;
  static double offsetProjects = 3 * SizeConfig.screenHeight;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void scrollTo(String title) {
    double offset = 0;
    switch (title) {
      case Constants.HOME:
        offset = offsetHome;
        break;
      case Constants.ABOUT:
        offset = offsetAbout;
        break;
      case Constants.BLOG:
        offset = offsetBlog;
        break;
      case Constants.PROJECTS:
        offset = offsetProjects;
        break;
    }

    setState(() {
      _curNavItem = title;
    });

    // animate to the pag
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics:
            PageScrollPhysics(), // use NeverScrollableScrollPhysics() to block user scrolling
        controller: _scrollController,
        slivers: <Widget>[
          // This is just SliverAppBar wrapped in InterheritedWidget called NavState
          // You can use just SliverAppBar
          NavState(
            curNavItem: _curNavItem,
            scrollTo: scrollTo,
            child:
                AppBanner(key: _appBannerKey), // SliverAppBar in another file
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              About(),
              Blog(),
              Projects(),
            ]),
          )
        ],
      ),
    );
  }
}
