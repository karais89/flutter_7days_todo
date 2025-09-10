import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('TODO App')),
      body: ListView.builder(
        itemCount: provider.todos.length,
        itemBuilder: (context, index) {
          final todo = provider.todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (_) => provider.toggle(index),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => provider.remove(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final controller = TextEditingController();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Add TODO'),
              content: TextField(controller: controller),
              actions: [
                TextButton(
                  onPressed: () {
                    provider.add(controller.text);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
