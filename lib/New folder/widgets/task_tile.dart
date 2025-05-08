import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;

  TaskTile({required this.task, required this.onDelete, required this.onToggleComplete});

  @override
  Widget build(BuildContext context) {
    final isDueSoon = task.dueDate.difference(DateTime.now()).inDays <= 1;

    return Card(
      color: isDueSoon && !task.isCompleted ? Colors.red[100] : null,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '${task.description}\nDue: ${task.dueDate.toLocal().toString().split(' ')[0]} | ${task.category.name}',
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.check, color: task.isCompleted ? Colors.green : Colors.grey),
              onPressed: onToggleComplete,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Confirm Delete"),
                    content: Text("Are you sure you want to delete this task?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Cancel")),
                      TextButton(onPressed: () {
                        Navigator.pop(ctx);
                        onDelete();
                      }, child: Text("Delete")),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
