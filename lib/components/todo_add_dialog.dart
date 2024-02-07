import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:todos/components/custom_button.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';
import 'package:todos/providers/todo_provider.dart';
import 'package:todos/utils/context_less_navigation.dart';
import 'package:todos/utils/global_function.dart';

class TodoAddDialog extends StatelessWidget {
  const TodoAddDialog({super.key});

  static TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: FutureBuilder<bool>(
          future: GlobalFunction.isOnline(),
          builder: (context, snapshot) {
            final bool isOnline = snapshot.data ?? false;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Todo',
                    style: AppTextStyle(context).title,
                  ),
                  Gap(20.h),
                  const TextField(
                    decoration: InputDecoration(labelText: 'Todo Title'),
                  ),
                  Gap(20.h),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: CustomButton(
                          buttonColor: AppColor.offWhite,
                          buttonTextColor: AppColor.black,
                          buttonText: 'Cancel',
                          onPressed: () {
                            context.nav.pop();
                          },
                        ),
                      ),
                      Gap(10.w),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Consumer(builder: (context, ref, _) {
                          return ref.watch(todoControllerProvider)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : CustomButton(
                                  buttonText: 'Save',
                                  onPressed: () {
                                    ref
                                        .read(todoControllerProvider.notifier)
                                        .addTodo(
                                            titleController.text, isOnline);
                                  },
                                );
                        }),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
