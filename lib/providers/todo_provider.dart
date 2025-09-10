import 'package:flutter/foundation.dart';
import '../models/todo.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void add(String title) {
    _todos.add(Todo(title: title));
    notifyListeners();
  }

  void toggle(int index) {
    _todos[index].isDone = !_todos[index].isDone;
    notifyListeners();
  }

  void remove(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }
}
