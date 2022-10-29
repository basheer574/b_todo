import 'package:b_todo/ui/widgets/todo_item_tile.dart';
import 'package:flutter/material.dart';

class ItemTileBottomDialogButton extends StatelessWidget {
  const ItemTileBottomDialogButton({
    Key? key,
    required this.size,
    required this.todoItemTile,
    required this.nameController,
    required this.descriptionController,
    required this.buttonText,
    required this.function,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  final Size size;
  final TodoItemTile todoItemTile;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final String buttonText;
  final VoidCallback function;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius
                        .circular(
                        16))),
            backgroundColor:
            MaterialStateProperty
                .all(buttonColor),
            minimumSize:
            MaterialStateProperty.all(
                Size(
                    size.width * 0.9,
                    60))),
        onPressed: function,
        child: Text(
          buttonText,
          style: TextStyle(
              color: textColor,
              fontSize: 18),
        ));
  }
}