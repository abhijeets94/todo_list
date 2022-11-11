import 'package:flutter/material.dart';
import 'package:todo_list/screens/todo.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.size,
    required this.text,
    required this.task,
    required this.taskCreated,
    required this.press,
    this.description,
    this.taskDueCreated,
  }) : super(key: key);

  final Size size;
  final TextTheme text;

  final String task;
  final String taskCreated;
  final String? taskDueCreated;
  final String? description;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        elevation: 5,
        shadowColor: Colors.black,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                // width: size.width * 0.1,
                height: double.maxFinite,
                color: Colors.teal,
                alignment: Alignment.center,
                child: Text(
                  taskCreated,
                  style: text.headline5!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    task,
                    style: text.headline6,
                  ),
                ),
              ),
              Container(
                  width: size.width * 0.1,
                  height: double.maxFinite,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline_outlined),
                    onPressed: press,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
