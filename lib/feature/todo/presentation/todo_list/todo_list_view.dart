import 'package:flutter/material.dart';
import 'package:sqflite_todo/feature/todo_details/presentation/todo_details_view.dart';
import 'package:sqflite_todo/services/sqflite_database/sqflite_database_service.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  List<Map<String, dynamic>> _todoModel = [];
  bool isloading = true;

  void _getdata() async {
    final data = await SqfliteDatabaseService.getTodos();
    setState(() {
      _todoModel = data;
      isloading = false;
    });
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? isSucess = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const TodoDetailsView(appbarTile: "Add Todos"),
            ),
          );
          if (isSucess == true) {
            _getdata();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _todoModel.length,
        itemBuilder: (context, index) {
          final todoIndex = _todoModel[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: Text(todoIndex["title"]),
              subtitle: Text(todoIndex["description"]),
              trailing: Chip(
                label: Text(
                  todoIndex["priority"],
                  style: TextStyle(
                      color: todoIndex["priority"] == "High"
                          ? Colors.red
                          : todoIndex["priority"] == "Medium"
                              ? Colors.orangeAccent
                              : Colors.grey),
                ),
              ),
              onTap: () async {
                bool? isSucess = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoDetailsView(
                      appbarTile: "Edit todos",
                      description: todoIndex['description'],
                      id: todoIndex['id'],
                      title: todoIndex['title'],
                      dropdownValue: todoIndex['priority'],
                    ),
                  ),
                );
                if (isSucess == true) {
                  _getdata();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
