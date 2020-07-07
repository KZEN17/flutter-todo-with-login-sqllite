import 'package:todoflutter/models/todo.dart';
import 'package:todoflutter/repositories/repository.dart';

class TodoService{
  Repository _repository;
  TodoService(){
    _repository = Repository();
  }
  saveTodo(Todo todo) async{
    return await _repository.insertData('todos', todo.todoMap());
  }
  readTodos() async{
    return await _repository.readData('todos');
  }
}