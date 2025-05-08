import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(Task) onAdd;

  AddTaskDialog({required this.onAdd});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _selectedDate;
  TaskCategory _selectedCategory = TaskCategory.Academic;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Task"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: InputDecoration(labelText: "Title")),
            TextField(controller: _descController, decoration: InputDecoration(labelText: "Description")),
            DropdownButton<TaskCategory>(
              value: _selectedCategory,
              onChanged: (val) => setState(() => _selectedCategory = val!),
              items: TaskCategory.values
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat.name)))
                  .toList(),
            ),
            ElevatedButton(
              child: Text(_selectedDate == null ? "Select Due Date" : _selectedDate.toString().split(' ')[0]),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
            )
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
        TextButton(
          onPressed: () {
            if (_titleController.text.isEmpty || _selectedDate == null) return;
            widget.onAdd(Task(
              title: _titleController.text,
              description: _descController.text,
              dueDate: _selectedDate!,
              category: _selectedCategory,
            ));
            Navigator.pop(context);
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
