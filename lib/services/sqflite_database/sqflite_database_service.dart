import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqfliteDatabaseService {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
title TEXT,
description TEXT,
priority TEXT,
createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");
  }

//open database
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "todo.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTable(database);
      },
    );
  }

//add todos
  static Future<int> addTodo(
      {required String title,
      required String description,
      required String priority}) async {
    final db = await SqfliteDatabaseService.db();
    final data = {
      'title': title,
      'description': description,
      'priority': priority
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

//get todos
  static Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await SqfliteDatabaseService.db();
    return db.query('items', orderBy: 'id');
  }

//get single todos
  static Future<List<Map<String, dynamic>>> getSingleTodos(int id) async {
    final db = await SqfliteDatabaseService.db();
    return db.query('items', where: "id=?", whereArgs: [id], limit: 1);
  }

  //update todos
  static Future<int> updateTodos(
      {required int id,
      String? title,
      String? description,
      String? priority}) async {
    final db = await SqfliteDatabaseService.db();
    final data = {
      'title': title,
      'description': description,
      'priority': priority,
      'createdAt': DateTime.now().toLocal().toString()
    };
    final result =
        await db.update('items', data, where: 'id=?', whereArgs: [id]);
    return result;
  }

  //delete todos
  static Future<void> deleteTodos({
    required int id,
  }) async {
    final db = await SqfliteDatabaseService.db();
    try {
      await db.delete('items', where: 'id=?', whereArgs: [id]);
    } catch (e) {
      if (kDebugMode) {
        print("Something went wrong when deleting item : $e ");
      }
    }
  }
}
