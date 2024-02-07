import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:todos/components/confirmation_dialog.dart';
import 'package:todos/components/custom_button.dart';
import 'package:todos/components/custom_text_form_field.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/providers/todo_provider.dart';
import 'package:todos/utils/context_less_navigation.dart';
import 'package:todos/utils/global_function.dart';

class TodoViewUpdateScreen extends ConsumerStatefulWidget {
  final Todo todo;
  const TodoViewUpdateScreen({super.key, required this.todo});

  @override
  ConsumerState<TodoViewUpdateScreen> createState() =>
      _TodoViewUpdateScreenState();
}

class _TodoViewUpdateScreenState extends ConsumerState<TodoViewUpdateScreen> {
  static TextEditingController titleController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.todo.title;
    super.initState();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.purple,
        title: Text(
          'Todo ',
          style: AppTextStyle(context).appBarText,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ConfirmationDialog(
                  isLoading: ref.watch(todoControllerProvider),
                  title: 'Are you sure want to delete this todo?',
                  confirmButtonText: 'Confirm',
                  onPressed: () {
                    ref
                        .read(todoControllerProvider.notifier)
                        .deleteTodo(id: widget.todo.id);
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: AppColor.red,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(60.h),
            CustomTextFormField(
              name: 'Title',
              textInputType: TextInputType.text,
              controller: titleController,
              textInputAction: TextInputAction.done,
              validator: (value) => GlobalFunction.commonValidator(
                  value: value!, name: 'Title', context: context),
              hintText: 'Start writing...',
              minLines: 3,
            ),
            Gap(40.h),
            ref.watch(todoControllerProvider)
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    buttonText: 'Update',
                    onPressed: () {
                      ref.read(todoControllerProvider.notifier).updateTodo(
                          id: widget.todo.id, title: titleController.text);
                      context.nav.pop();
                    },
                  )
          ],
        ),
      ),
    );
  }

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor; // iOS device ID
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id; // Android device ID
      }
    } catch (e) {
      debugPrint('Error getting device ID: $e');
      return null;
    }
    return null;
  }
}
