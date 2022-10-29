import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../data/model/domain/todo.dart';
import '../data/model/repository/todo_repository.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({required this.repository}) : super(TodoLoading()) {
    on<LoadTodosEvent>((event, emit) async {
      emit(TodoLoading());
      await repository.buildDatabase();
      final todos = await repository.getTodos();
      todos != null && todos.isNotEmpty
          ? emit(TodoLoaded(todos: todos))
          : emit(const TodoError(errorMessage: 'Failed To Load Todos'));
    });
    on<AddTodoEvent>((event,emit) async{
      await repository.insertTodo(event.todo);
      add(LoadTodosEvent());
    });
    on<DeleteTodoEvent>((event,emit) async{
      await repository.deleteTodo(event.todo);
      add(LoadTodosEvent());
    });
    on<UpdateTodoEvent>((event,emit) async{
      await repository.updateTodo(event.todo);
      add(LoadTodosEvent());
    });
  }
}
