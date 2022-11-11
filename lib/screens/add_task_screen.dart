import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/task_controller.dart';
import 'package:todo_list/screens/todo.dart';

import '../util/custom_text_field.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add-task-screen';

  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != DateTime.now()) {
        taskController.dueDate = picked;
        taskController.setDate(picked);
      }
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(
                flex: 2,
              ),
              Text(
                "Add New Task",
                style: text.headline5,
              ),
              // const Spacer(),
              CustomTextField(
                textEditingController: controller.taskEditingController!,
                hintText: "Task",
              ),
              CustomTextField(
                textEditingController: controller.descriptionEditingController!,
                hintText: "Description",
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Text("${taskController.dueDate!.toLocal()}".split(' ')[0]),
                  Obx(() {
                    return Text(
                      "${taskController.getDate.toLocal()}".split(' ')[0],
                      style: text.headline6,
                    );
                  }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  IconButton(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  if (taskController.getDate
                          .difference(DateTime.now())
                          .inDays >=
                      0) {
                    controller.addTask();
                    debugPrint("List of task => ${taskController.taskList}");
                    Get.back();
                  } else {
                    Get.snackbar(
                      "Time machine has not been invented yet ;)",
                      "",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Container(
                    width: double.infinity,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                    child: Text(
                      "Add Task",
                      style: text.button!
                          .copyWith(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
