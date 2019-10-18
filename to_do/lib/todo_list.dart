import 'package:flutter/material.dart';
import 'package:to_do/Percentage.dart';
import 'todo.dart';
import 'todo_todo.dart';
import 'todo_todo_list.dart';
import 'del.dart';
import 'filterOptions.dart';
import 'opns2.dart';

class ToDoList extends StatefulWidget {
  final List<ToDos> todos;
  final Function deleteTodo;
  final Function rename;
  final Function updateTodopercent;
  final Function updateToDoList;
  final Function updateChoice;

  ToDoList(this.todos, this.deleteTodo, this.rename, this.updateTodopercent,
      this.updateToDoList, this.updateChoice);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Options selectedChoice = options[0];
  String opts = "All";
  final myController = TextEditingController();

  void _addNewTodoTodo(String todo, DateTime time, ToDos todos) {
    final newTodoTodo = ToDoToDo(
      todo: todo,
      time: time,
      id: DateTime.now().toString(),
      check: false,
      count: 0,
    );
    setState(() {
      todos.todoList.add(newTodoTodo);
      widget.updateTodopercent(todos);
    });
  }

  void _promptUpdateTodo(ToDos todos) {
    myController.text = todos.todoTitle;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new TextField(
                controller: myController,
                decoration: InputDecoration(labelText: 'Rename Todo'),
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('update'),
                    onPressed: () {
                      widget.rename(todos, myController.text);
                      myController.clear();
                      Navigator.of(context).pop();
                    }),
                new FlatButton(
                    child: new Text('cancel'),
                    onPressed: () {
                      myController.clear();
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _promptAddTodoTodoItem(ToDos todos) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new TextField(
                controller: myController,
                decoration: InputDecoration(labelText: 'Add Todo'),
              ),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('add'),
                    onPressed: () {
                      myController.text.isEmpty ? print('ToDoToDo') :  _addNewTodoTodo(myController.text, DateTime.now(), todos);
                      myController.clear();
                      Navigator.of(context).pop();
                    }),
                new FlatButton(
                    child: new Text('cancel'),
                    onPressed: () {
                      myController.clear();
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  void _deleteTodoTodo(List<ToDoToDo> todos, String id) {
    setState(() {
      todos.removeWhere((tid) {
        return tid.id == id;
      });
    });
  }

  void renameTodo(ToDoToDo toDoToDo, String todo) {
    setState(() {
      toDoToDo.todo = todo;
    });
  }

  String dropdownValue = 'All';

  @override
  Widget build(BuildContext context) {
    return widget.todos.isEmpty
        ? Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(50.0),
                  child: Text(
                    'No Todos Yet!',
                    style: TextStyle(
                        fontSize: 40.0,
                        color: Color.fromRGBO(255, 220, 222, 0.4),
                        fontWeight: FontWeight.bold),
                  )
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 200.0,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return Card(
                color:Colors.blue[50],
                elevation: 40,
                margin: EdgeInsets.only(left:35.0,right: 15.0,top:40.0,bottom:40.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.0)),
                child: Container(
                  width: 310.0,
                  height: 590.0,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            width: 120.0,
                            margin: EdgeInsets.only(top: 30.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Container(
                                height: 20.0,
                                width: 70.0,
                                child: Text(
                                  widget.todos[index].todoTitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 95.0,
                            margin: EdgeInsets.only(top: 30.0),
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.black38,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                                widget.updateChoice(
                                    dropdownValue, widget.todos[index]);
                              },
                              items: <String>[
                                'All',
                                'Active',
                                'Completed'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text("  " + value),
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left:10.0,),
                            width: 40.0,
                            margin: EdgeInsets.only(top: 30.0),
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _promptAddTodoTodoItem(widget.todos[index]);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(),
                            margin: EdgeInsets.only(top: 28.0),
                            child: widget.todos[index].all
                                ? PopupMenuButton(
                                    itemBuilder: (BuildContext context) {
                                      return options.map((Options choice) {
                                        return new PopupMenuItem(
                                          value: choice,
                                          child: ListTile(
                                            title: choice.opt,
                                            leading: choice.ic,
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (choice) {
                                      choiceAction(
                                          choice,
                                          widget.todos[index].id,
                                          widget.todos[index]);
                                    },
                                  )
                                : PopupMenuButton(
                                    itemBuilder: (BuildContext context) {
                                      return choiceoptions
                                          .map((ChoiceOptions choice) {
                                        return new PopupMenuItem(
                                          value: choice,
                                          child: ListTile(
                                            title: choice.opt,
                                            leading: choice.ic,
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (choice) {
                                      choiceAction2(
                                          choice,
                                          widget.todos[index].id,
                                          widget.todos[index]);
                                    },
                                  ),
                          )
                        ],
                      ),
                      Percentage(widget.todos[index].toDoPercent),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.lightBlueAccent,
                        ),
                        height: 350.0,
                        child: chooseTodoList(widget.todos[index], opts),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: widget.todos.length,
          );
  }

  Widget chooseTodoList(ToDos toDos, String opts) {
    if (toDos.all) {
      print('passed All');
      return ToDoToDoList(
          _deleteTodoTodo,
          renameTodo,
          widget.updateTodopercent,
          toDos,
          toDos.todoList,
          widget.updateToDoList,
          opts,
          widget.updateChoice);
    } else if (toDos.active) {
      print('passed Active');
      return ToDoToDoList(
          _deleteTodoTodo,
          renameTodo,
          widget.updateTodopercent,
          toDos,
          toDos.activeList,
          widget.updateToDoList,
          opts,
          widget.updateChoice);
    } else if (toDos.completed) {
      print('passed Completed');
      return ToDoToDoList(
          _deleteTodoTodo,
          renameTodo,
          widget.updateTodopercent,
          toDos,
          toDos.completedList,
          widget.updateToDoList,
          opts,
          widget.updateChoice);
    } else {
      return Container(
        child: Text('Sorry error occured'),
      );
    }
  }

  void choiceAction(Options choice, String id, ToDos todos) {
    print(id);
    setState(() {
      if (choice.opt.toString() == "Text(\"Delete\")") {
        widget.deleteTodo(id);
        print('Delete');
      } else if (choice.opt.toString() == "Text(\"Rename\")") {
        _promptUpdateTodo(todos);
        print('Rename');
      } else if (choice.opt.toString() == "Text(\"Clear Completed\")") {
        clearCompleted(todos);
        print('Clear Completed');
      } else if (choice.opt.toString() == "Text(\"Mark all complete\")") {
        markAllComplete(todos);
        print('Mark all complete');
      } else {
        print('Nothing');
      }
    });
  }

  void choiceAction2(ChoiceOptions choice, String id, ToDos todos) {
    print(id);
    setState(() {
      if (choice.opt.toString() == "Text(\"Delete\")") {
        widget.deleteTodo(id);
        print('Delete');
      } else if (choice.opt.toString() == "Text(\"Rename\")") {
        _promptUpdateTodo(todos);
        print('Rename');
      } else {
        print('Nothing');
      }
    });
  }

  void markAllComplete(ToDos toDos) {
    setState(() {
      for (int i = 0; i < toDos.todoList.length; i++) {
        toDos.todoList[i].count = 1;
        toDos.todoList[i].check = true;
        widget.updateTodopercent(toDos);
        widget.updateToDoList(toDos);
      }
    });
  }

  void clearCompleted(ToDos toDos) {
    setState(() {
      toDos.todoList.removeWhere((tid) {
        return tid.count == 1;
      });
      widget.updateTodopercent(toDos);
      widget.updateToDoList(toDos);
    });
  }

  void filterChoice(FilterOptions choice, String choice2, ToDos toDos) {
    setState(() {
      if (choice.opt.toString() == "Text(\"All\")") {
        print('All');
        toDos.all = true;
        toDos.active = false;
        toDos.completed = false;
      } else if (choice.opt.toString() == "Text(\"Active\")") {
        print('Active');
        toDos.all = false;
        toDos.active = true;
        toDos.completed = false;
      } else if (choice.opt.toString() == "Text(\"Completed\")") {
        print('Completed');
        toDos.all = false;
        toDos.active = false;
        toDos.completed = true;
      } else {
        print('Nothing');
      }
    });
  }

  double getPercent(ToDos todos) {
    int count1 = 0;
    double percent;
    if (todos.todoList.length == 0) {
      return 0.0;
    } else {
      for (int i = 0; i < todos.todoList.length; i++) {
        count1 += todos.todoList[i].count;
      }
      percent = count1.toDouble() / todos.todoList.length.toDouble();
      return percent;
    }
  }
}
