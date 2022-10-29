import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../domain/todo.dart';
import '../domain/todo_dao.dart';

part 'todo_database.g.dart';

@Database(version: 1, entities: [Todo])
abstract class TodoDatabase extends FloorDatabase{
  TodoDao get todoDao;
}