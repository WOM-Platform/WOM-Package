import 'package:flutter/widgets.dart';

onWidgetDidBuild(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}