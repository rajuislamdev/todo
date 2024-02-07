import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/models/todo.dart';
import 'package:todos/services/todo_service.dart';

class TodoController extends StateNotifier<bool> {
  final Ref ref;
  TodoController(this.ref) : super(false);

  Future<void> addTodo(String title, bool online) async {
    state = true;
    if (online) {
      await ref.read(todoServiceProvider).addTodoOnline(title);
      state = false;
    } else {
      await ref.read(todoServiceProvider).addTodoOffline(title);
      state = false;
    }
    state = false;
  }

  Future<void> updateTodoStatus(String id, bool isCompleted,
      {bool online = true}) async {
    if (online) {
      await ref
          .read(todoServiceProvider)
          .updateTodoStatusOnline(id, isCompleted);
    } else {
      await ref
          .read(todoServiceProvider)
          .updateTodoStatusOffline(id, isCompleted);
    }
  }

  Future<void> deleteTodo(String id, {bool online = true}) async {
    if (online) {
      await ref.read(todoServiceProvider).deleteTodoOnline(id);
    } else {
      await ref.read(todoServiceProvider).deleteTodoOffline(id);
    }
  }

  Stream<List<Todo>> getTodos({bool online = true}) {
    return online
        ? ref.read(todoServiceProvider).getTodosOnlineAndOffline()
        : ref.read(todoServiceProvider).getTodosOffline();
  }
}
