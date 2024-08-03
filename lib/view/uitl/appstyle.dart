import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shortnews/view/uitl/appColors.dart';
import 'package:shortnews/view/uitl/apphelper.dart';

class AppStyle {
  static final heading_white = TextStyle(
      color: Colors.white70, fontSize: 17.5.sp, fontWeight: FontWeight.w700);
  static final heading_black = TextStyle(
      color: AppColors.blackColor,
      fontSize: 17.5.sp,
      fontWeight: FontWeight.w700);

  static final bodytext_white = TextStyle(
    color: Color.fromARGB(255, 224, 221, 221),
    fontSize: 16.8.sp,
    fontWeight: FontWeight.w200,
    wordSpacing: 2,
  );
  static final bodytext_black = TextStyle(
    color: AppColors.blackColor,
    fontSize: 16.5.sp,
    fontWeight: FontWeight.w200,
    wordSpacing: 2,
  );
  static final cardtitles = TextStyle(
    color: AppHelper.themelight ? AppColors.whiteColor : AppColors.blackColor,
    fontSize: 16.sp,
    wordSpacing: 2,
  );
}
