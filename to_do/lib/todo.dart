import 'todo_todo.dart';

class ToDos{
  final String id;
  String todoTitle;
  final DateTime time;
  List<ToDoToDo> todoList;
  List<ToDoToDo> activeList;
  List<ToDoToDo> completedList;
  double toDoPercent;
  bool all;
  bool active;
  bool completed;
  // final ToDoToDo toDoToDo;

  ToDos({
    this.id,
    this.todoTitle,
    this.time,
    this.todoList,
    this.toDoPercent,
    this.all,
    this.active,
    this.completed,
    this.activeList,
    this.completedList
  });
}

