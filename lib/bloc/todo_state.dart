part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable{
  const TodoState();
}

class TodoLoading extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoLoaded extends TodoState{

  final List<Todo> todos;
  const TodoLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoAdd extends TodoState{
  @override
  List<Object> get props => [];
}

class TodoDelete extends TodoState{
  @override
  List<Object?> get props => [];
}

class TodoUpdate extends TodoState{
  @override
  List<Object?> get props => [];
}

class TodoError extends TodoState{
  final String errorMessage;
  const TodoError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}