
import 'package:flutter/material.dart';

class AddTodoBottomDialogButton extends StatelessWidget {
  const AddTodoBottomDialogButton({
    Key? key,
    required this.size,
    required this.todoNameController,
    required this.todoDescriptionController,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.function,
  }) : super(key: key);

  final Size size;
  final TextEditingController todoNameController;
  final TextEditingController todoDescriptionController;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16))),
            backgroundColor:
            MaterialStateProperty.all(buttonColor),
            minimumSize: MaterialStateProperty.all(
                Size(size.width * 0.9, 60))),
        onPressed: function,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor, fontSize: 18),
        ));
  }
}