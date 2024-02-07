import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/controllers/todo_controller.dart';

final todoControllerProvider = Provider((ref) => TodoController(ref));
