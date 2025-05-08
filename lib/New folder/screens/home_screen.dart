import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../widgets/add_task_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  String searchQuery = '';

  void _addTask(Task task) => setState(() => tasks.add(task));
  void _deleteTask(Task task) => setState(() => tasks.remove(task));
  void _toggleComplete(Task task) => setState(() => task.isCompleted = !task.isCompleted);

  @override
  Widget build(BuildContext context) {
    final filteredTasks = tasks.where((task) =>
      task.title.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Asian College TO-DO"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: TaskSearch(tasks)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredTasks.length,
        itemBuilder: (ctx, i) => TaskTile(
          task: filteredTasks[i],
          onDelete: () => _deleteTask(filteredTasks[i]),
          onToggleComplete: () => _toggleComplete(filteredTasks[i]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => AddTaskDialog(onAdd: _addTask),
        ),
      ),
    );
  }
}

class TaskSearch extends SearchDelegate {
  final List<Task> allTasks;

  TaskSearch(this.allTasks);

  @override
  List<Widget>? buildActions(BuildContext context) => [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  @override
  Widget? buildLeading(BuildContext context) => BackButton();

  @override
  Widget buildResults(BuildContext context) {
    final results = allTasks.where((task) => task.title.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView(
      children: results.map((task) => ListTile(title: Text(task.title))).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}
