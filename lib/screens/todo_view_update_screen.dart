import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';
import 'package:todos/models/todo.dart';

class TodoViewUpdateScreen extends StatelessWidget {
  final Todo todo;
  const TodoViewUpdateScreen({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.purple,
        title: Text(
          'Todo ID: ${todo.id}',
          style: AppTextStyle(context).appBarText,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        child: Column(
          children: [
            Text(
              'Title',
              style: AppTextStyle(context).title,
            )
          ],
        ),
      ),
    );
  }
}
