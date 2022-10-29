
import 'package:flutter/material.dart';

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.minLinesNumber,
    required this.maxLinesNumber,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final int minLinesNumber;
  final int maxLinesNumber;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      reverse: true,
      child: TextFormField(
        minLines: minLinesNumber,
        maxLines: maxLinesNumber,
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.green)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(color: Colors.blueGrey)),
        ),
      ),
    );
  }
}