import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/screens/add_task_screen.dart';
import 'package:todo_list/screens/todo.dart';

import '../screens/edit_task_screen.dart';

generateRoute() {
  return [
    GetPage(
      name: Todo.routeName,
      page: () => Todo(),
    ),
    GetPage(
      name: AddTaskScreen.routeName,
      page: () => AddTaskScreen(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: EditTaskScreen.routeName,
      page: () => EditTaskScreen(),
      transition: Transition.topLevel,
    ),
  ];
}
