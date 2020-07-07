import 'package:flutter/material.dart';
import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todoflutter/services/todo_service.dart';

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
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadCategories();
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
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Create Todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: todoTitleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter Todo',
                ),
              ),
              TextField(
                controller: todoDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Desription',
                  hintText: 'Enter Description',
                ),
              ),
              TextField(
                controller: todoDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
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
                  value: _selectedValue,
                  items: _categories,
                  hint: Text('Category'),
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
                    _showSuccessSnackBar(Text('Created'));
                  }
                  print(result);
                },
                color: Colors.green,
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
