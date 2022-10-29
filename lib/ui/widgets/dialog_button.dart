import 'package:b_todo/ui/widgets/todo_item_tile.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    required this.todoItemTile, required this.buttonText, required this.color, required this.function,
  }) : super(key: key);

  final TodoItemTile todoItemTile;
  final String buttonText;
  final Color color;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: function,
        child: Text(
          buttonText,
          style:
          TextStyle(color: color),
        ));
  }
}
