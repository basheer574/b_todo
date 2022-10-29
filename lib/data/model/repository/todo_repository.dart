
import 'package:logger/logger.dart';

import '../database/todo_database.dart';
import '../domain/todo.dart';
import '../domain/todo_dao.dart';

class TodoRepository{
  Logger logger = Logger();
  TodoDatabase? database;
  List<Todo>? todoList;
  TodoDao? todoDao;

  TodoRepository();

  Future<void> buildDatabase() async{
    database = await $FloorTodoDatabase.databaseBuilder('todo_database.db')
        .build();
    todoDao = database?.todoDao;
  }
  Future<List<Todo>?> getTodos() async{
    todoList = await todoDao?.getAllTodos();
    logger.v("My List: $todoList");
    return todoList;
  }

  Future<void>? insertTodo(Todo todo) => todoDao?.insertTodo(todo);

  Future<void>? deleteTodo(Todo todo) => todoDao?.deleteTodo(todo);

  Future<void>? updateTodo(Todo todo) {todoDao?.updateTodo(todo); logger.v("Update Todo : $todo");}
}