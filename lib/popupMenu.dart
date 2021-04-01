import 'dart:ui';
import 'package:flutter/material.dart';

class FocusedMenuHolder extends StatefulWidget {
  final Widget child;
  final double menuItemExtent;
  final double menuWidth;
  final List<FocusedMenuItem> menuItems;
  final bool animateMenuItems;
  final BoxDecoration menuBoxDecoration;
  final Function onPressed;
  final Duration duration;
  final double blurSize;
  final Color blurBackgroundColor;
  final double bottomOffsetHeight;
  final double menuOffset;
  final Color arrowColor;
  final int animationDuration;

  /// Open with tap insted of long press.
  final bool openWithTap;

  const FocusedMenuHolder(
      {Key key,
      @required this.child,
      @required this.onPressed,
      @required this.menuItems,
      this.duration,
      this.menuBoxDecoration,
      this.menuItemExtent,
      this.animateMenuItems,
      this.animationDuration,
      this.blurSize,
      this.blurBackgroundColor,
      this.arrowColor,
      this.menuWidth,
      this.bottomOffsetHeight,
      this.menuOffset,
      this.openWithTap = false})
      : super(key: key);

  @override
  _FocusedMenuHolderState createState() => _FocusedMenuHolderState();
}

class _FocusedMenuHolderState extends State<FocusedMenuHolder> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = Offset(0, 0);
  Size childSize;

  getOffset() {
    RenderBox renderBox = containerKey.currentContext.findRenderObject();
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      this.childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: containerKey,
        onTap: () async {
          widget.onPressed();
          if (widget.openWithTap) {
            await openMenu(context);
          }
        },
        onLongPress: () async {
          if (!widget.openWithTap) {
            await openMenu(context);
          }
        },
        child: widget.child);
  }

  Future openMenu(BuildContext context) async {
    getOffset();
    await Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: widget.duration ?? Duration(milliseconds: 100),
            pageBuilder: (context, animation, secondaryAnimation) {
              animation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(
                  opacity: animation,
                  child: FocusedMenuDetails(
                    itemExtent: widget.menuItemExtent,
                    menuBoxDecoration: widget.menuBoxDecoration,
                    child: widget.child,
                    childOffset: childOffset,
                    childSize: childSize,
                    menuItems: widget.menuItems,
                    blurSize: widget.blurSize,
                    menuWidth: widget.menuWidth,
                    blurBackgroundColor: widget.blurBackgroundColor,
                    animateMenu: widget.animateMenuItems ?? true,
                    bottomOffsetHeight: widget.bottomOffsetHeight ?? 0,
                    menuOffset: widget.menuOffset ?? 0,
                    arrowColor: widget.arrowColor,
                    animationDuration: widget.animationDuration,
                  ));
            },
            fullscreenDialog: true,
            opaque: false));
  }
}

class FocusedMenuDetails extends StatelessWidget {
  final List<FocusedMenuItem> menuItems;
  final BoxDecoration menuBoxDecoration;
  final Offset childOffset;
  final double itemExtent;
  final Size childSize;
  final Widget child;
  final bool animateMenu;
  final double blurSize;
  final double menuWidth;
  final Color blurBackgroundColor;
  final Color arrowColor;
  final Color itemBackgroundColor;
  final double bottomOffsetHeight;
  final double menuOffset;
  final int animationDuration;

  const FocusedMenuDetails(
      {Key key,
      @required this.menuItems,
      @required this.child,
      @required this.childOffset,
      @required this.childSize,
      @required this.menuBoxDecoration,
      @required this.itemExtent,
      @required this.animateMenu,
      @required this.blurSize,
      @required this.blurBackgroundColor,
      @required this.menuWidth,
      this.animationDuration,
      this.itemBackgroundColor,
      this.arrowColor,
      this.bottomOffsetHeight,
      this.menuOffset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final maxMenuHeight = size.height * 0.45;
    final listHeight = menuItems.length * (itemExtent ?? 50.0);

    final maxMenuWidth = menuWidth ?? (size.width * 0.70);
    final menuHeight = listHeight < maxMenuHeight ? listHeight : maxMenuHeight;
    final leftOffset = (childOffset.dx + maxMenuWidth) < size.width
        ? childOffset.dx
        : (childOffset.dx - maxMenuWidth + childSize.width);
    final topOffset = (childOffset.dy + menuHeight + childSize.height) <
            size.height - bottomOffsetHeight
        ? childOffset.dy + childSize.height + menuOffset
        : childOffset.dy - menuHeight - menuOffset;
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: blurSize ?? 4, sigmaY: blurSize ?? 4),
                  child: Container(
                    color: blurBackgroundColor ?? Colors.black,
                  ),
                )),
            Positioned(
              top: topOffset,
              left: leftOffset + (menuWidth - 35),
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: animationDuration ?? 100),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (BuildContext context, value, Widget child) {
                  return Transform.scale(
                    scale: value,
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                child: ClipPath(
                    clipper: ArrowCliper(),
                    child: Container(
                      height: 20,
                      width: 20,
                      color: arrowColor ?? Colors.grey[700],
                    )),
              ),
            ),
            Positioned(
              top: topOffset + 20,
              left: leftOffset,
              child: TweenAnimationBuilder(
                duration: Duration(milliseconds: animationDuration ?? 100),
                builder: (BuildContext context, value, Widget child) {
                  return Transform.scale(
                    scale: value,
                    alignment: Alignment.center,
                    child: child,
                  );
                },
                tween: Tween(begin: 0.0, end: 1.0),
                child: Container(
                  width: maxMenuWidth,
                  height: menuHeight + 5,
                  decoration: menuBoxDecoration ??
                      BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: ListView.builder(
                      itemCount: menuItems.length,
                      padding: EdgeInsets.zero,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        FocusedMenuItem item = menuItems[index];
                        Widget listItem = GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              item.onPressed();
                            },
                            child: Container(
                                width: menuWidth,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 1),
                                color: item.backgroundColor ?? Colors.white,
                                height: itemExtent ?? 50.0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 14),
                                  child: Wrap(
                                    runSpacing: 5,
                                    spacing: 20,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      if (item.leadingWidget != null) ...[
                                        item.leadingWidget
                                      ],
                                      item.title,
                                      if (item.trailingWidget != null) ...[
                                        item.trailingWidget
                                      ]
                                    ],
                                  ),
                                )));
                        if (animateMenu) {
                          return TweenAnimationBuilder(
                              builder: (context, value, child) {
                                return Transform(
                                  transform: Matrix4.rotationX(1.5708 * value),
                                  alignment: Alignment.bottomCenter,
                                  child: child,
                                );
                              },
                              tween: Tween(begin: 1.0, end: 0.0),
                              duration: Duration(milliseconds: index * 200),
                              child: listItem);
                        } else {
                          return listItem;
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FocusedMenuItem {
  Color backgroundColor;
  Widget title;
  Widget trailingWidget;
  Widget leadingWidget;
  Function onPressed;

  FocusedMenuItem(
      {this.backgroundColor,
      @required this.title,
      this.leadingWidget,
      this.trailingWidget,
      @required this.onPressed});
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
