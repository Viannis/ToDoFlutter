import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/todo_list.dart';
import 'todo.dart';
import 'todo_todo.dart';

void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<ToDos> _userTodos = [];
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _addNewTodo(String todoTitle,DateTime time){
    final newTodo = ToDos( 
      todoTitle: todoTitle,
      time: time,
      id: DateTime.now().toString(),
      todoList: [],
      toDoPercent: 0.0,
      all: true,
      active: false,
      completed: false,
      activeList: [],
      completedList: []
    );
    setState(() {
      _userTodos.add(newTodo); 
    });
  }

  void _promptAddTodoItem() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new TextField(
            controller: myController,
            decoration: InputDecoration( 
              labelText: 'Add a List'
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('add'),
              onPressed: () {
                myController.text.isEmpty ? print('NoTodo') : _addNewTodo(myController.text, DateTime.now());
                myController.clear();
                Navigator.of(context).pop();
              }
            ),
            new FlatButton(
              child: new Text('cancel'),
              onPressed: () {
                myController.clear();
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );  
  }

  void _deleteTodo(String id) {
    setState((){
      _userTodos.removeWhere((td){
        return td.id == id;
      });
    });
  }

  void updateToDoPercent(ToDos toDos1){
    setState((){
      int count1 = 0;
      double percent;
      if(toDos1.todoList.length == 0){
        toDos1.toDoPercent = 0.0;
      }
      else{
        for(int i = 0;i<toDos1.todoList.length;i++){
          count1 += toDos1.todoList[i].count;
        }
        percent = count1.toDouble() / toDos1.todoList.length.toDouble();
        toDos1.toDoPercent = percent;
      }
      updateToDoList(toDos1);
    });
  }

  void updateToDoList(ToDos toDos){
    print('entered update todos');
    setState(() {
      List<ToDoToDo> at = [];
      toDos.activeList = [];
      toDos.completedList = [];
      print(toDos.activeList.isEmpty);
      print(toDos.completedList.isEmpty);
      List<ToDoToDo> ct = [];
      for(int i = 0;i<toDos.todoList.length;i++){
        if(toDos.todoList[i].count == 0){
          ct.add(toDos.todoList[i]);
          toDos.activeList = ct;
        }
        else if(toDos.todoList[i].count == 1){
          at.add(toDos.todoList[i]);
          toDos.completedList = at;
        }
      } 
    });
  }

  void rename(ToDos todos,String todoTitle){
    setState(() {
      todos.todoTitle = todoTitle;
    });  
  }

  void updateChoice(String choice,ToDos toDos){
    print(choice);
    setState(() {
      if(choice == "All"){
        print('All');
        toDos.all = true;
        toDos.active = false;
        toDos.completed = false;
      }
      else if(choice == "Active"){
        print('Active');
        toDos.all = false;
        toDos.active = true;
        toDos.completed = false;
      }
      else if(choice == "Completed"){ 
        print('Completed');
        toDos.all = false;
        toDos.active = false;
        toDos.completed = true;
      }
      else{
        print('Nothing');
      } 
      updateToDoList(toDos);
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height:MediaQuery.of(context).size.height + 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                Colors.purple[600],
                Colors.purple[500],
                Colors.purple[400],
                Colors.purple[300],
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                margin:EdgeInsets.only(top:55.0),
                child: Text(
                  'ToDo',
                  style:TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromRGBO(204, 153, 255, 0.9)
                  ),
                  textAlign: TextAlign.start,
                )
              ),
              Divider(endIndent: 50.0,color: Color.fromRGBO(204, 153, 255, 0.7),thickness: 4.0,),
              Container(
                height:600.0,
                child: ToDoList(_userTodos, _deleteTodo, rename, updateToDoPercent, updateToDoList, updateChoice),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: _promptAddTodoItem,),
    );
  }
}