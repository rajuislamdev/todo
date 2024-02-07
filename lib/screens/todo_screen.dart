import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todos/components/todo_add_dialog.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/providers/todo_provider.dart';
import 'package:todos/routes.dart';
import 'package:todos/utils/context_less_navigation.dart';
import 'package:todos/utils/global_function.dart';

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
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const TodoAddDialog());
        },
        child: const Icon(
          Icons.add,
          color: AppColor.white,
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return FutureBuilder(
              future: GlobalFunction.getDeviceId(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final String? deviceId = snapshot.data;

                  return StreamBuilder<List<Todo>>(
                    stream: ref
                        .watch(todoControllerProvider.notifier)
                        .getTodos(deviceId: deviceId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final todos = snapshot.data ?? [];
                        return todos.isEmpty
                            ? Center(
                                child: Text(
                                  'No todo found!',
                                  style: AppTextStyle(context).subTitle,
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.only(top: 10.h),
                                itemCount: todos.length,
                                itemBuilder: (context, index) {
                                  final todo = todos[index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 5.h),
                                    child: ListTile(
                                      onTap: () {
                                        context.nav.pushNamed(
                                            Routes.todoViewUpdate,
                                            arguments: todo);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                      tileColor: AppColor.offWhite,
                                      title: Text(
                                        todo.title,
                                        style: AppTextStyle(context)
                                            .subTitle
                                            .copyWith(
                                              decoration: todo.isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      ),
                                      trailing: Checkbox(
                                        value: todo.isCompleted,
                                        onChanged: (value) {
                                          ref
                                              .read(todoControllerProvider
                                                  .notifier)
                                              .updateTodoStatus(
                                                id: todo.id,
                                                isCompleted: value ?? false,
                                              );
                                        },
                                      ),
                                      onLongPress: () {},
                                    ),
                                  );
                                },
                              );
                      }
                    },
                  );
                }
              });
        },
      ),
    );
  }
}
