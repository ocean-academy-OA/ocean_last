import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:ocean_project/desktopview/screen/translate_on_hover.dart';

extension HoverExtension on Widget {
  static final appContainer =
      html.window.document.getElementById('app-container');
  Widget get showCursorOnHover {
    return MouseRegion(
      child: this,
      onHover: (event) => appContainer.style.cursor = 'pointer',
      onExit: (event) => appContainer.style.cursor = 'default',
    );
  }

  Widget get moveUpOnHover {
    return TranslateOnHover(
      child: this,
    );
  }
}
