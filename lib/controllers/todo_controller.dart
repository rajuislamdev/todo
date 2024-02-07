import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/todo_service.dart';

class TodoController extends StateNotifier<bool> {
  final Ref ref;
  TodoController(this.ref) : super(false);

  Future<void> addTodo({required String title}) async {
    state = true;
    await ref.read(todoServiceProvider).addTodo(title: title);
    state = false;
  }

  Future<void> updateTodoStatus({
    required String id,
    required bool isCompleted,
  }) async {
    try {
      await ref.read(todoServiceProvider).updateTodoStatus(
            id: id,
            isCompleted: isCompleted,
          );
      state = false;
    } catch (error) {
      debugPrint(error.toString());
      state = false;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      state = true;
      await ref.read(todoServiceProvider).deleteTodo(id);
      state = false;
    } catch (error) {
      debugPrint(error.toString());
      state = false;
    }
  }

  Stream<List<Todo>> getTodos({bool online = true}) {
    return ref.read(todoServiceProvider).getTodos();
  }
}
