import 'package:b_todo/ui/widgets/todo_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/bloc_imports.dart';
import '../../data/model/domain/todo.dart';
import 'item_tile_bottom_dialog_button.dart';
import 'dialog_button.dart';

class TodoItemTile extends StatefulWidget {
  const TodoItemTile({Key? key, required this.todo}) : super(key: key);
  final Todo todo;

  @override
  State<TodoItemTile> createState() => _TodoItemTileState();
}

class _TodoItemTileState extends State<TodoItemTile>
    with TickerProviderStateMixin {
  bool isDone = false;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..forward(from: 0.0);

  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoaded) {
          return ScaleTransition(
            scale: animation,
            child: Card(
              elevation: 3.0,
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32))),
              child: ExpansionTile(
                textColor: Colors.green,
                title: Text(
                  widget.todo.name.toString(),
                  style: TextStyle(
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      widget.todo.description.toString(),
                      maxLines: 1,
                      style: TextStyle(
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Checkbox(
                            value: isDone,
                            fillColor: MaterialStateProperty.all(Colors.green),
                            onChanged: (bool? value) {
                              setState(() {
                                isDone = value!;
                                if (isDone == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Task is Done!"),
                                          duration:
                                              Duration(milliseconds: 500)));
                                }
                              });
                            }),
                        IconButton(
                            onPressed: () {
                              nameController.text = widget.todo.name!;
                              descriptionController.text =
                                  widget.todo.description!;
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: const ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(32),
                                          topLeft: Radius.circular(32))),
                                  elevation: 3.0,
                                  builder: (context) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: size.height * 0.8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Update Todo",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.green),
                                              ),
                                              const SizedBox(height: 12),
                                              TodoTextField(
                                                controller: nameController,
                                                hintText: 'Todo Name',
                                                maxLinesNumber: 1,
                                                minLinesNumber: 1,
                                              ),
                                              const SizedBox(height: 12),
                                              TodoTextField(
                                                  controller:
                                                      descriptionController,
                                                  hintText: 'Description',
                                                  minLinesNumber: 3,
                                                  maxLinesNumber: 5),
                                              const SizedBox(height: 12),
                                              ButtonTheme(
                                                child:
                                                    ItemTileBottomDialogButton(
                                                  size: size,
                                                  todoItemTile: widget,
                                                  nameController:
                                                      nameController,
                                                  descriptionController:
                                                      descriptionController,
                                                  function: () {
                                                    BlocProvider.of<TodoBloc>(
                                                            context)
                                                        .add(UpdateTodoEvent(
                                                            todo: Todo(
                                                                id:
                                                                    widget.todo
                                                                        .id,
                                                                name:
                                                                    nameController
                                                                        .text,
                                                                description:
                                                                    descriptionController
                                                                        .text)));
                                                    Navigator.pop(context);
                                                  },
                                                  buttonText: 'Update',
                                                  buttonColor: Colors.green,
                                                  textColor: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              ButtonTheme(
                                                  child:
                                                      ItemTileBottomDialogButton(
                                                size: size,
                                                nameController: nameController,
                                                descriptionController:
                                                    descriptionController,
                                                buttonText: 'Cancel',
                                                textColor: Colors.black,
                                                buttonColor: Colors.white,
                                                function: () {
                                                  Navigator.pop(context);
                                                },
                                                todoItemTile: widget,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueGrey,
                            )),
                        IconButton(
                            onPressed: () {
                              showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete Todo?'),
                                      shape: ContinuousRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      elevation: 2.0,
                                      content: const Text(
                                          'Are You Sure You Want To Delete This Todo?'),
                                      actions: [
                                        DialogButton(
                                          buttonText: 'Cancel',
                                          color: Colors.blue,
                                          todoItemTile: widget,
                                          function: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        DialogButton(
                                          todoItemTile: widget,
                                          color: Colors.green,
                                          function: () {
                                            BlocProvider.of<TodoBloc>(context)
                                                .add(DeleteTodoEvent(
                                                    todo: widget.todo));
                                            Navigator.of(context).pop();
                                          },
                                          buttonText: 'Delete',
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon:
                                const Icon(Icons.delete, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
                children: [
                  ListTile(
                    title: Text(
                      widget.todo.name.toString(),
                      style: const TextStyle(color: Colors.green),
                    ),
                    subtitle: Expanded(
                      child: Text(
                        maxLines: 5,
                        widget.todo.description.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is TodoError) {
          const Center(child: CircularProgressIndicator(color: Colors.green));
        }
        return Center(child: Lottie.asset('asset/no_todo_found.json'));
      },
    );
  }
}
