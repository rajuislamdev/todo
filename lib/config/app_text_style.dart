import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/config/app_color.dart';

class AppTextStyle {
  final BuildContext context;
  AppTextStyle(this.context);

  TextStyle get title => TextStyle(
        color: AppColor.black,
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
      );
  TextStyle get subTitle => TextStyle(
        color: AppColor.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      );
  TextStyle get bodyText => TextStyle(
        color: AppColor.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );
  TextStyle get bodyTextSmall => TextStyle(
        color: AppColor.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );
  TextStyle get buttonText => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      );
  TextStyle get hintText => TextStyle(
        color: AppColor.black,
        fontSize: 21.sp,
        fontWeight: FontWeight.w300,
      );
  TextStyle get appBarText => TextStyle(
        color: AppColor.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );
}
