import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todos/models/todo.dart';

class TodoService {
  final Ref ref;
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');

  TodoService(this.ref);

  Future<void> addTodo({
    required String? deviceId,
    required String title,
  }) async {
    try {
      await todosCollection.add({
        'deviceId': deviceId,
        'title': title,
        'isCompleted': false,
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> updateTodoStatus({
    required String id,
    required bool isCompleted,
  }) async {
    await todosCollection.doc(id).update({'isCompleted': isCompleted});
  }

  Future<void> updateTodo({
    required String id,
    required String title,
  }) async {
    await todosCollection.doc(id).update({'title': title});
  }

  Future<void> deleteTodo({required String id}) async {
    await todosCollection.doc(id).delete();
  }

  Stream<List<Todo>> getTodos({required String? deviceId}) {
    return todosCollection
        .where('deviceId', isEqualTo: deviceId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Todo(
          id: doc.id,
          title: doc['title'],
          isCompleted: doc['isCompleted'],
        );
      }).toList();
    });
  }
}

final todoServiceProvider = Provider((ref) => TodoService(ref));
