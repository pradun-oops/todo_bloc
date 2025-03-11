// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/todo_model.dart';

class DbHelper {
  DbHelper._();
  static DbHelper getInstance() => DbHelper._();
  static const String TODO_TABLE = 'toDos';
  static const String TODO_TABLE_ID = 'id';
  static const String TODO_TITLE = 'title';
  static const String TODO_DESCRIPTION = 'description';
  static const String TODO_CREATED_AT = 'createdAT';
  static const String TODO_COMPLETED = 'completed';

  Database? _db;

  Future<Database> getDB() async {
    _db ??= await openDB();
    return _db!;
  }

  Future<Database> openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, 'todoDB.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
                db.execute( "CREATE TABLE $TODO_TABLE ($TODO_TABLE_ID INTEGER PRIMARY KEY AUTOINCREMENT,$TODO_TITLE TEXT,$TODO_DESCRIPTION TEXT,$TODO_CREATED_AT TEXT,$TODO_COMPLETED INTEGER)");
      },
    );
  }

  Future<bool> addToDo({required ToDoModel newToDo}) async {
    Database db = await getDB();
    int rowEffect = await db.insert(TODO_TABLE, newToDo.toMap());
    return rowEffect > 0;
  }

  Future<List<ToDoModel>> fetchAllToDo() async {
    var db = await getDB();
    List<Map<String, dynamic>> toDo = await db.query(TODO_TABLE);
    List<ToDoModel> allToDos = [];

    for (Map<String, dynamic> eachToDo in toDo) {
      allToDos.add(ToDoModel.fromMap(eachToDo));
    }
    return allToDos;
  }

  Future<bool> updateToDo(ToDoModel updatedToDo) async {
    var db = await getDB();
    int rowsEffected = await db.update(
      TODO_TABLE,
      updatedToDo.toMap(),
      where: "$TODO_TABLE_ID = ?",
      whereArgs: [updatedToDo.id],
    );

    return rowsEffected > 0;
  }

  Future<bool> deleteToDo(int id) async {
    var db = await getDB();
    int rowsEffected = await db.delete(
      TODO_TABLE,
      where: "$TODO_TABLE_ID = ?",
      whereArgs: [id],
    );

    return rowsEffected > 0;
  }

  Future<bool> completedTask(int id , bool value) async {
    var db = await getDB();
    int rowsEffected = await db.update(
      TODO_TABLE,
      {TODO_COMPLETED: value ? 1 : 0},
      where: "$TODO_TABLE_ID = ?",
      whereArgs: [id],
    );

    return rowsEffected > 0;
  }
}
