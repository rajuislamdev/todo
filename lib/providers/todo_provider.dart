import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/controllers/todo_controller.dart';

final todoControllerProvider =
    StateNotifierProvider<TodoController, bool>((ref) => TodoController(ref));
