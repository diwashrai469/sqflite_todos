import 'package:flutter/material.dart';
import 'package:sqflite_todo/common/widgets/k_dropdown_widgets.dart';
import 'package:sqflite_todo/services/sqflite_database/sqflite_database_service.dart';

class TodoDetailsView extends StatefulWidget {
  final String appbarTile;
  final String? title;
  final int? id;
  final String? description;
  final String? dropdownValue;
  const TodoDetailsView(
      {super.key,
      required this.appbarTile,
      this.title,
      this.dropdownValue,
      this.description,
      this.id});

  @override
  State<TodoDetailsView> createState() => _EditTodoViewState();
}

class _EditTodoViewState extends State<TodoDetailsView> {
  var priorityLists = ["High", "Medium", "Low"];
  String dropdownValue = "High";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title ?? '';
    descriptionController.text = widget.description ?? '';
    dropdownValue = widget.dropdownValue ?? dropdownValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appbarTile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kDropDown(
              dropdownvalue: dropdownValue,
              items: priorityLists
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value ?? '';
                });
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                label: Text("Title"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                label: Text("Description"),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (widget.id == null) {
                        await SqfliteDatabaseService.addTodo(
                                title: titleController.text,
                                description: descriptionController.text,
                                priority: dropdownValue)
                            .then((value) => Navigator.pop(context, true));
                      } else {
                        await SqfliteDatabaseService.updateTodos(
                                id: widget.id!,
                                title: titleController.text,
                                description: descriptionController.text,
                                priority: dropdownValue)
                            .then((value) => Navigator.pop(context, true));
                      }
                    },
                    child: const Text("Save")),
                if (widget.appbarTile == "Edit todos")
                  ElevatedButton(
                      onPressed: () async {
                        await SqfliteDatabaseService.deleteTodos(id: widget.id!)
                            .then((value) => Navigator.pop(context, true));
                      },
                      child: const Text("Delete"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
