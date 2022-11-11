import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/task.dart';

class TaskController extends GetxController {
  final _taskList = <Task>[].obs;
  Rxn<DateTime> _date = Rxn<DateTime>();

  List<Task> get taskList => _taskList.value;
  DateTime get getDate => _date.value!;

  TextEditingController? taskEditingController;
  TextEditingController? descriptionEditingController;
  DateTime? dueDate;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    taskEditingController = TextEditingController();
    descriptionEditingController = TextEditingController();
    _date.value = DateTime.now();
    dueDate = _date.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskEditingController!.dispose();
    descriptionEditingController!.dispose();
  }

  //add task
  void addTask() {
    String task = taskEditingController!.text;
    String description = descriptionEditingController!.text;
    DateTime time = DateTime.now();

    _taskList.add(
      Task(
        task: task,
        description: description,
        taskCreated: time,
        taskDueCreated: dueDate!,
      ),
    );
  }

  void setDate(DateTime userDate) {
    _date.value = userDate;
  }

  void editNote(int index) {
    String task = taskEditingController!.text;
    String description = descriptionEditingController!.text;

    // debugPrint("Edit value => ${_taskList.value[index].task}");
    _taskList.value[index] = Task(
        task: task,
        taskCreated: DateTime.now(),
        description: description,
        taskDueCreated: dueDate);
  }

  //delete task
  void deleteTask(Task task) {
    taskList.remove(task);
  }
}
