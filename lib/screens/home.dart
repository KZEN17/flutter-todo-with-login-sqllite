import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/screens/categories.dart';
import 'package:todoflutter/screens/todo_screen.dart';
import 'package:todoflutter/services/todo_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  TodoService _todoService;
  List<Todo> _todoList = List<Todo>();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = List<Todo>();

    var todos = await _todoService.readTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.todoDate = todo['todoDate'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  _deleteFormDialog(BuildContext context, todoId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.green,
                onPressed: () => Navigator.of(context).pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                  color: Colors.red,
                  onPressed: () async {
                    var result = await _todoService.deleteTodo(todoId);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllTodos();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen()));
                      _showSuccessSnackBar(Text(
                        "Completed",
                        style: TextStyle(
                            backgroundColor: Colors.green, color: Colors.white),
                      ));
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen()));
                    }
                    print(result);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
            title: Text('Great Job!'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text(
          '.',
          style: TextStyle(color: Colors.grey[900]),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
//        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            'My Tasks',
            style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w200,
                color: Colors.purpleAccent),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.grey[900],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.purpleAccent),
        unselectedIconTheme: IconThemeData(color: Colors.purpleAccent),
        backgroundColor: Colors.grey[800],
        items: [
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CategoriesScreen()));
                  },
                  child: Icon(Icons.category)),
              title: Text(
                'Categories',
                style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.no_sim,
                color: Colors.grey[800],
              ),
              title: Text('')),
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: (){

                  },
                  child: Icon(
                Icons.list,
                size: 30.0,
              )),
              title: Text(
                '',
                style: TextStyle(fontSize: 0.1),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
            itemCount: _todoList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  color: Colors.black,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () {
                      _deleteFormDialog(context, _todoList[index].id);
                    },
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Text(
                            _todoList[index].title ?? 'No Title',
                            style: TextStyle(color: Colors.purpleAccent),
                          )
                        ],
                      ),
                      subtitle: Text(
                        _todoList[index].category ?? 'No Category',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      trailing: Text(
                          _todoList[index].todoDate ?? 'No Todo Date',
                          style: TextStyle(color: Colors.white38)),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.purpleAccent,
          size: 40.0,
        ),
      ),
    );
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(
      content: message,
      backgroundColor: Colors.green,
    );
    _globalKey.currentState.showSnackBar(_snackBar);
  }
}
