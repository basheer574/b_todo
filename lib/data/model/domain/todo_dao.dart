import 'package:b_todo/data/model/domain/todo.dart';
import 'package:floor/floor.dart';

@dao
abstract class TodoDao{
  @Query('SELECT * FROM Todo')
  Future<List<Todo>> getAllTodos();

  @Query('SELECT * FROM Todo WHERE id = :id')
  Future<Todo?> getTodoById(int id);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertTodo(Todo todo);

  @Query('DELETE FROM Todo')
  Future<void> deleteAllTodo();

  @delete
  Future<void> deleteTodo(Todo todo);

  @update
  Future<void> updateTodo(Todo todo);
}