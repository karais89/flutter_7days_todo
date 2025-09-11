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
      body: provider.todos.isEmpty
          ? const Center(
              child: Text(
                "할 일이 없습니다",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context, index) {
                final todo = provider.todos[index];
                return Dismissible(
                  key: ValueKey(todo.title + index.toString()),
                  background: Container(color: Colors.red),
                  onDismissed: (_) => provider.remove(index),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) => provider.toggle(index),
                      ),
                      title: Text(
                        todo.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                          color: todo.isDone ? Colors.grey : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => provider.remove(index),
                      ),
                    ),
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
