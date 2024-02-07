import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  final String name;
  final FocusNode? focusNode;
  final TextInputType textInputType;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Widget? widget;
  final bool? obscureText;
  final int? minLines;
  final bool showName;
  final String hintText;
  const CustomTextFormField({
    Key? key,
    required this.name,
    this.focusNode,
    required this.textInputType,
    required this.controller,
    required this.textInputAction,
    required this.validator,
    this.readOnly,
    this.widget,
    this.obscureText,
    this.minLines,
    this.showName = true,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showName)
          Text(
            name,
            style: AppTextStyle(context)
                .bodyText
                .copyWith(fontWeight: FontWeight.w500),
          ),
        Gap(12.h),
        AbsorbPointer(
          absorbing: readOnly ?? false,
          child: FormBuilderTextField(
            readOnly: readOnly ?? false,
            textAlign: TextAlign.start,
            minLines: minLines ?? 1,
            maxLines: minLines ?? 1,
            name: name,
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText ?? false,
            style: AppTextStyle(context).bodyText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            cursorColor: AppColor.purple,
            obscuringCharacter: '●',
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 16),
              alignLabelWithHint: true,
              hintText: hintText,
              hintStyle: AppTextStyle(context).bodyText.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightGray,
                  ),
              suffixIcon: widget,
              floatingLabelStyle: AppTextStyle(context).bodyText.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.purple,
                  ),
              filled: true,
              fillColor: AppColor.white,
              errorStyle: AppTextStyle(context).bodyTextSmall.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColor.red,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: AppColor.lightGray),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide:
                    const BorderSide(color: AppColor.offWhite, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: AppColor.purple, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColor.red,
                ),
              ),
            ),
            keyboardType: textInputType,
            textInputAction: textInputAction,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
