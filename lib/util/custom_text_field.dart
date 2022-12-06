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
        style: const TextStyle(
          color: Colors.white,
          fontFamily: "NerkoOne-Regular",
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontFamily: "NerkoOne-Regular",
            fontSize: 20,
            fontWeight: FontWeight.w100,
          ),
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
