// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color? buttonColor;
  final Color buttonTextColor;
  final void Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.buttonColor,
    this.buttonTextColor = AppColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor:
            MaterialStateProperty.all(buttonColor ?? AppColor.purple),
        minimumSize: MaterialStateProperty.all(
          Size(double.infinity, 50.h),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.r),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: AppTextStyle(context).buttonText.copyWith(
              color: buttonTextColor,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
