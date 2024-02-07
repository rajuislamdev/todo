import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todos/models/todo.dart';

class TodoService {
  final Ref ref;
  final CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('todos');
  late Database _localDatabase;

  TodoService(this.ref) {
    _initLocalDatabase();
  }

  Future<void> _initLocalDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'local_database.db');
    _localDatabase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE todos (
            id TEXT PRIMARY KEY,
            title TEXT,
            isCompleted INTEGER
          )
        ''');
    });
  }

  Future<void> addTodoOnline(String title) async {
    await todosCollection.add({
      'title': title,
      'isCompleted': false,
    });
  }

  Future<void> addTodoOffline(String title) async {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      isCompleted: false,
    );
    await _localDatabase.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTodoStatusOnline(String id, bool isCompleted) async {
    await todosCollection.doc(id).update({'isCompleted': isCompleted});
  }

  Future<void> updateTodoStatusOffline(String id, bool isCompleted) async {
    await _localDatabase.update(
      'todos',
      {'isCompleted': isCompleted ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTodoOnline(String id) async {
    await todosCollection.doc(id).delete();
  }

  Future<void> deleteTodoOffline(String id) async {
    await _localDatabase.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Stream<List<Todo>> getTodosOnline() {
    return todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Todo(
          id: doc.id,
          title: doc['title'],
          isCompleted: doc['isCompleted'],
        );
      }).toList();
    });
  }

  Stream<List<Todo>> getTodosOffline() {
    return Stream.fromFuture(_localDatabase
        .query('todos')
        .then((value) => value.map((e) => Todo.fromMap(e)).toList()));
  }

  Stream<List<Todo>> getTodosOnlineAndOffline() {
    // Combine online and offline streams
    return StreamGroup.merge<List<Todo>>([
      getTodosOnline(),
      getTodosOffline(),
    ]);
  }
}

final todoServiceProvider = Provider((ref) => TodoService(ref));
