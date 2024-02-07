import 'package:flutter/material.dart';
import 'package:todos/config/app_text_style.dart';

class TodoViewUpdateScreen extends StatelessWidget {
  const TodoViewUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo View',
          style: AppTextStyle(context).appBarText,
        ),
      ),
    );
  }
}
