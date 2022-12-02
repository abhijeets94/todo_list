import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/task_controller.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 245, 110, 101),
            ),
          ),
        ),
      ),
    );
  }
}
