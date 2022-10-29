import 'package:b_todo/ui/views/home_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc_imports.dart';
import 'data/model/repository/todo_repository.dart';

void main() {
  Bloc.observer = TodoBlocObserver();
  runApp(const BTodo());
}

class BTodo extends StatefulWidget {
  const BTodo({Key? key}) : super(key: key);

  @override
  State<BTodo> createState() => _BTodoState();
}

class _BTodoState extends State<BTodo> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      TodoBloc(repository: TodoRepository())
        ..add(LoadTodosEvent()),
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen()
      ),
    );
  }
}
