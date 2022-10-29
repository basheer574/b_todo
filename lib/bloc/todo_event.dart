part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodoEvent{}
class AddTodoEvent extends TodoEvent{
  final Todo todo;
  AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
class DeleteTodoEvent extends TodoEvent{
  final Todo todo;
  DeleteTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
class UpdateTodoEvent extends TodoEvent{
  final Todo todo;
  UpdateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}