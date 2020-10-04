import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ScreenAdaper {
  static void init(context) {
    ScreenUtil.init(
      context,
      designSize: Size(1200, 1824),
      allowFontScaling: true,
    );
  }

  static double height(double height) {
    return ScreenUtil().setHeight(height);
  }

  static double width(double width) {
    return ScreenUtil().setWidth(width);
  }

  static double getScreenHeith() {
    return ScreenUtil().screenHeight;
  }

  static double getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static double getScreenWidthPx() {
    return ScreenUtil().screenWidthPx;
  }
}
