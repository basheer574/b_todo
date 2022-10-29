import 'package:auto_animated/auto_animated.dart';
import 'package:b_todo/bloc/bloc_imports.dart';
import 'package:b_todo/constants.dart';
import 'package:b_todo/ui/widgets/todo_item_tile.dart';
import 'package:b_todo/ui/widgets/todo_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import '../../data/model/domain/todo.dart';
import '../widgets/add_todo_bottom_dialog_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final log = Logger();

  final todoNameController = TextEditingController();
  final todoDescriptionController = TextEditingController();
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('My Todos',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.green)),
                        const SizedBox(height: 10),
                        Expanded(
                            child: ListView.builder(
                              addAutomaticKeepAlives: false,
                              padding: const EdgeInsets.all(8),
                              scrollDirection: Axis.vertical,
                              itemCount: state.todos.length,
                              itemBuilder: (context, index) {
                                return TodoItemTile(todo: state.todos[index]);
                              },
                            ))
                      ]),
                ),
              );
            } else if (state is TodoError) {
              const Center(
                  child: CircularProgressIndicator(color: Colors.green));
            }
            return Center(child: Lottie.asset('asset/no_todo_found.json'));
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: size.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "New Todo",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.green),
                        ),
                        const SizedBox(height: 12),
                        TodoTextField(
                            controller: todoNameController,
                            hintText: 'Todo Name',
                            minLinesNumber: 1,
                            maxLinesNumber: 2),
                        const SizedBox(height: 12),
                        TodoTextField(
                            controller: todoDescriptionController,
                            hintText: 'Description',
                            minLinesNumber: 3,
                            maxLinesNumber: 5),
                        const SizedBox(height: 12),
                        ButtonTheme(
                          child: AddTodoBottomDialogButton(
                            buttonText: 'Add',
                            size: size,
                              todoNameController: todoNameController,
                              todoDescriptionController: todoDescriptionController,
                            function: (){
                              if (todoNameController.text.isNotEmpty &&
                                  todoDescriptionController.text.isNotEmpty) {
                                BlocProvider.of<TodoBloc>(context).add(
                                    AddTodoEvent(
                                        todo: Todo(
                                            name: todoNameController.text,
                                            description:
                                            todoDescriptionController
                                                .text)));
                              }
                              todoNameController.clear();
                              todoDescriptionController.clear();
                              Navigator.of(context).pop();
                            },
                            buttonColor: Colors.green,
                            textColor: Colors.white,

                          ),
                        ),
                        const SizedBox(height: 15),
                        ButtonTheme(
                          child: AddTodoBottomDialogButton(
                            buttonText: 'Cancel',
                            textColor: Colors.black,
                            buttonColor: Colors.white,
                            size: size,
                            todoNameController: todoNameController,
                            todoDescriptionController: todoDescriptionController,
                            function: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                backgroundColor: backgroundColor,
                shape: const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32))),
                elevation: 3.0,
              );
            },
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            backgroundColor: Colors.green,
            child: const Icon(Icons.add, color: Colors.white, size: 32)));
  }
}

