import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:practical/src/utils/pref.util.dart';

dynamic getSize(double px) {
  return MathUtilities.getInstance().getWidth(px);
}

class MathUtilities {
  static MathUtilities _utils = new MathUtilities();
  int width;
  bool allowFontScaling;
  static double _screenWidth = 414;
  static double _screenHeight = 736;
  static double _pixelRatio = 2;
  static double _statusBarHeight = 24;
  static double _bottomBarHeight = 48;
  static double? _textScaleFactor = 1;

  MathUtilities({
    this.width = 414,
    this.allowFontScaling = false,
  });
  static MathUtilities getInstance() {
    return _utils;
  }

  Future init(BuildContext context) async {
    Map<String, dynamic> screenDataMap = HashMap();
    if ((await PrefUtils().getStringAsync("MEDIAQUERY")).isEmpty) {
      var mediaQuery = MediaQuery.of(context);
      screenDataMap["devicePixelRatio"] = mediaQuery.devicePixelRatio;
      screenDataMap["width"] = mediaQuery.size.width;
      screenDataMap["height"] = mediaQuery.size.height;
      screenDataMap["top"] = mediaQuery.padding.top;
      screenDataMap["bottom"] = mediaQuery.padding.bottom;
      screenDataMap["textScaleFactor"] = mediaQuery.textScaleFactor;
      await PrefUtils()
          .saveStringAsync("MEDIAQUERY", jsonEncode(screenDataMap));
    } else {
      screenDataMap =
          jsonDecode(await PrefUtils().getStringAsync("MEDIAQUERY"));
    }
    _pixelRatio = screenDataMap["devicePixelRatio"];
    _screenWidth = screenDataMap["width"];
    _screenHeight = screenDataMap["height"];
    _statusBarHeight = screenDataMap["top"];
    _bottomBarHeight = screenDataMap["bottom"];
    _textScaleFactor = screenDataMap["textScaleFactor"];
  }

  static double get textScaleFactory => _textScaleFactor ?? 1;
  static double get pixelRatio => _pixelRatio;
  static double get screenWidthDp => _screenWidth;
  static double get screenHeightDp => _screenHeight;

  static double get screenWidth => (_screenWidth) * (_pixelRatio);
  static double get screenHeight => _screenHeight * _pixelRatio;
  static double get statusBarHeight => _statusBarHeight * _pixelRatio;
  static double get bottomBarHeight => _bottomBarHeight * _pixelRatio;

  get scaleWidth => (_screenWidth) / _utils.width;
  getWidth(double width) => width * scaleWidth;

  double getSp(double fontSize) {
    if (_textScaleFactor == null) return fontSize;
    return allowFontScaling
        ? getWidth(fontSize)
        : getWidth(fontSize) / _textScaleFactor;
  }
}
