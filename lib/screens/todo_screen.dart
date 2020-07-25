import 'package:flutter/material.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/screens/home.dart';
import 'package:todoflutter/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todoflutter/services/todo_service.dart';

import 'categories.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();
  var _selectedValue;
  var _categories = List<DropdownMenuItem>();
  bool _validate = false;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }
  @override
  void dispose() {
    todoTitleController.dispose();
    super.dispose();
  }


  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }
  _showSuccessSnackBar(message){
    var _snackBar = SnackBar(content: message, backgroundColor: Colors.green,);
    _globalKey.currentState.showSnackBar(_snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: Colors.purpleAccent),
        unselectedIconTheme: IconThemeData(color: Colors.purpleAccent),
        backgroundColor: Colors.grey[800],
        items: [
          BottomNavigationBarItem(
              icon: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HomeScreen()));
                  },
                  child: Icon(
                    Icons.home,
                    size: 30.0,
                  )),
              title: Text(
                '',
                style: TextStyle(fontSize: 0.1),
              )),

          BottomNavigationBarItem(
              icon: Icon(
                Icons.no_sim,
                color: Colors.grey[800],
              ),
              title: Text('')),
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

        ],
      ),
      backgroundColor: Colors.grey[900],
      key: _globalKey,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text('Zen Tasks',style: TextStyle(color: Colors.purpleAccent, fontSize: 50.0, fontStyle: FontStyle.italic,),),
//                Container(
//                  height: 150,
//                  width: 150,
//                  color: Colors.purple,
//                  child: Text('Z Tasks', style: TextStyle(color: Colors.white, fontSize: 50.0, letterSpacing: 2.0),),
//                ),
                TextField(
                  controller: todoTitleController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)
                    ),
                    labelText: 'Title',
                    errorText: _validate ? 'Please Enter Title' : null,
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Todo',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextField(
                  cursorColor: Colors.white,
                  controller: todoDescriptionController,
                  decoration: InputDecoration(

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)
                    ),
                    labelText: 'Desription',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Enter Description',
                    hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
                TextField(
                  controller: todoDateController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54)
                    ),
                    labelText: 'Date',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Choose a date',
                    prefixIcon: InkWell(
                      onTap: () {
                        _selectedTodoDate(context);
                      },
                      child: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration.collapsed(
                      hintText: "",
                      ),
                    value: _selectedValue,
                    items: _categories,
                    hint: Text('   Category', style: TextStyle(color: Colors.white),),style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    }),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: () async{
                    var todoObject = Todo();
                    todoObject.title = todoTitleController.text;
                    todoObject.description = todoDescriptionController.text;
                    todoObject.isFinished = 0;
                    todoObject.category = _selectedValue.toString();
                    todoObject.todoDate = todoDateController.text;
                    var _todoService = TodoService();
                    var result = await _todoService.saveTodo(todoObject);
                    if(result > 0){
//                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TodoScreen()));
                      _showSuccessSnackBar(Text('Created'));
                      todoTitleController.clear();
                      todoDescriptionController.clear();
                      todoDateController.clear();
                    }
                  },
                  color: Colors.purpleAccent,
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
