import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/components/todo_add_dialog.dart';
import 'package:todos/config/app_color.dart';
import 'package:todos/config/app_text_style.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/providers/todo_provider.dart';
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
          return FutureBuilder<bool>(
            future: GlobalFunction.isOnline(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Loading state while checking connectivity
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Error state
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final bool isOnline = snapshot.data ?? false;
                print('Online status:$isOnline');
                return StreamBuilder<List<Todo>>(
                  stream: ref
                      .watch(todoControllerProvider)
                      .getTodos(online: isOnline),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Loading state
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      // Error state
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      // Data loaded successfully
                      final todos = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return ListTile(
                            title: Text(todo.title),
                            trailing: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) {
                                ref
                                    .read(todoControllerProvider)
                                    .updateTodoStatus(
                                      todo.id,
                                      value ?? false,
                                      online: isOnline,
                                    );
                              },
                            ),
                            onLongPress: () {
                              ref
                                  .read(todoControllerProvider)
                                  .deleteTodo(todo.id, online: isOnline);
                            },
                          );
                        },
                      );
                    }
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
