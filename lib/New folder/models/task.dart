enum TaskCategory { Academic, Personal, Work }

class Task {
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  TaskCategory category;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.category,
  });
}
