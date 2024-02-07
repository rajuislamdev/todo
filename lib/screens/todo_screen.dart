import 'package:flutter/material.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.purple,
        title: Text(
          'Todo Screen',
          style: AppTextStyle(context).appBarText,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.purple,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: AppColor.white,
        ),
      ),
    );
  }
}
