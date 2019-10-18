import 'package:flutter/material.dart';
import 'todo_todo.dart';
import 'todo.dart';
import 'opns.dart';
import 'package:intl/intl.dart';

class ToDoToDoList extends StatefulWidget {
  final Function deleteTodoTodo;
  final Function renameTodo;
  final Function updateToDoPercent;
  final ToDos toDos;
  final List<ToDoToDo> todoList;
  final Function updateToDoList;
  final String opts;
  final Function choice;

  ToDoToDoList(this.deleteTodoTodo,this.renameTodo,this.updateToDoPercent,this.toDos, this.todoList, this.updateToDoList, this.opts, this.choice);

  @override
  _ToDoToDoListState createState() => _ToDoToDoListState();
}

class _ToDoToDoListState extends State<ToDoToDoList> {
  
  final myController = TextEditingController();
  
  List<ToDoToDo> finalTodo= [];
  @override
  void initState(){
    super.initState();
    setState(() {
      finalTodo = getListTodo(widget.toDos);
      print(finalTodo);
    });
    print(finalTodo);
  }

  List<ToDoToDo> getListTodo(ToDos todo){
    List<ToDoToDo> completedTodoList = [];
    List<ToDoToDo> activeTodoList = [];
    for(int i=0;i<todo.todoList.length;i++){
      if(todo.todoList[i].count == 1){
        setState(() {
          completedTodoList.add(todo.todoList[i]); 
        });
      }
      else if(todo.todoList[i].count == 0){
        setState(() {
          activeTodoList.add(todo.todoList[i]);  
        });
      }
      else{
          print(" here ");
          return todo.todoList;
      }
    }
    if(todo.all){
      return todo.todoList;
    }
    else if(todo.active){
      return activeTodoList;
    }
    else if(todo.completed){
      return completedTodoList;
    }
    else{
      return todo.todoList;
    }
  }

  void showTextCard(ToDoToDo toDoToDo){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog( 
          content: Container(
            child: Text(DateFormat.yMMMd().format(toDoToDo.time),style:TextStyle(fontSize: 15.0,color:Colors.grey),),
          ),
          title: Text(toDoToDo.todo,style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color:Colors.black),),
          titlePadding: EdgeInsets.all(20.0),
        );
      }
    );
  }

  void _promptUpdateTodoTodo(ToDoToDo todos) {
    myController.text = todos.todo;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new TextField(
            controller: myController,
            decoration: InputDecoration(
              labelText: 'Edit Todo'
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('update'),
              onPressed: () {
                widget.renameTodo(todos,myController.text);
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

  @override
  Widget build(BuildContext context) {
    return widget.todoList.isEmpty ? 
    Container(
      width:double.infinity,
      child: selectTodo(widget.toDos),
    ) : ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: ((ctx,index){
        return Card( 
          color: Color.fromRGBO(255, 255, 255, 0.8),
          elevation: 5.0,
          margin:EdgeInsets.only(left:10.0,right:10.0,bottom:5.0,top:5.0),
          child:ListTile(
            onLongPress: (){
              showTextCard(widget.todoList[index]);
            }, 
            leading: widget.toDos.all ? Checkbox( 
              value: widget.todoList[index].check,
              onChanged: (bool value){
                setState(() {
                   widget.todoList[index].check = value;
                   if(widget.todoList[index].check){
                     widget.todoList[index].count = 1;
                     widget.updateToDoPercent(widget.toDos);
                     widget.updateToDoList(widget.toDos);
                      
                      widget.choice(widget.opts,widget.toDos);
                   }
                   else{
                     widget.todoList[index].count = 0;
                     widget.updateToDoPercent(widget.toDos);
                     widget.updateToDoList(widget.toDos);
                    
                     widget.choice(widget.opts,widget.toDos);
                   }
                });
              },
            ) : null,
            title: Container(child: Text(widget.todoList[index].todo,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0))),
            trailing: widget.toDos.all ? PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return options.map((Opns choice){
                  return new PopupMenuItem(
                    value: choice,
                    child: new ListTile( 
                      title: choice.opt,
                      leading: choice.ic,
                    ),
                  );
                }).toList();
              },
              onSelected: (choice) {
                choiceSelect(choice,widget.todoList,widget.todoList[index].id,widget.todoList[index],widget.toDos);
              } ,
            ) : null,
          )
        );
      }),
    );
  }
  void choiceSelect(Opns choice,List<ToDoToDo> todos,String id,ToDoToDo todo,ToDos toDos){
    print(id);
    setState(() {
      if(choice.opt.toString() == "Text(\"Delete\")"){
        widget.deleteTodoTodo(todos,id);
        widget.updateToDoPercent(toDos);
        print('Delete');
      }
      else if(choice.opt.toString() == "Text(\"Edit\")"){
        _promptUpdateTodoTodo(todo);
        print('Edit');
      }
      else{
        print('Nothing');
      }
    });
  }

  Widget selectTodo(ToDos toDos){
    if(toDos.all){
      return Column( 
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30.0),
            child: Text('No ToDos Yet!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.indigoAccent),),
          ),
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.all(20.0),
            height:200.0,
            child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)
          ),
        ],
      );
    }
    else if(toDos.active){
      return Container( 
        padding : EdgeInsets.all(30.0),
        child: Text('You have completed all Todos',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.indigoAccent),),
      );
    }
    else if(toDos.completed){
      return Container(
        padding : EdgeInsets.all(30.0),
        child: Text('You haven\'t completed any Todo',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.indigoAccent),),
      );
    }
    else{
      return Container( 
        padding : EdgeInsets.all(30.0),
        child: Text('Sorry some error occured',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0,color: Colors.indigoAccent),),
      );
    }
  }

  double getPer(ToDos todos){
    print('getPer');
    int count1 = 0;
    double percent;
    for(int i = 0;i<todos.todoList.length;i++){
      count1 += todos.todoList[i].count;
    }
    percent = count1.toDouble() / todos.todoList.length.toDouble();
    print(percent.toString());
    return percent;
  }
}