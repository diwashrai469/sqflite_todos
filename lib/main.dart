import 'package:flutter/material.dart';
import 'package:sqflite_todo/feature/todo/presentation/todo_list/todo_list_view.dart';

// sqflite gives us the data in map form

void main(List<String> args) {
  runApp(
    const MaterialApp(
      home: TodoListView(),
    ),
  );
}
