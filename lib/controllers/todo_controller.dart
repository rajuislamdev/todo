import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/todo_service.dart';

class TodoController extends StateNotifier<bool> {
  final Ref ref;
  TodoController(this.ref) : super(false);

  Future<void> addTodo({
    required String? deviceId,
    required String title,
  }) async {
    try {
      state = true;
      await ref
          .read(todoServiceProvider)
          .addTodo(deviceId: deviceId, title: title)
          .then((value) {
        state = false;
      });
    } catch (error) {
      state = false;
      debugPrint(error.toString());
    }
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
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateTodo({
    required String id,
    required String title,
  }) async {
    try {
      await ref.read(todoServiceProvider).updateTodo(
            id: id,
            title: title,
          );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> deleteTodo({required String id}) async {
    try {
      await ref.read(todoServiceProvider).deleteTodo(id: id);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Stream<List<Todo>> getTodos({required String? deviceId}) {
    return ref.read(todoServiceProvider).getTodos(deviceId: deviceId);
  }
}
