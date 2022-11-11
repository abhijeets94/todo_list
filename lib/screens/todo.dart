import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todo_list/controller/task_controller.dart';
import 'package:todo_list/screens/add_task_screen.dart';
import 'package:todo_list/screens/edit_task_screen.dart';

import '../util/task_tile.dart';

class Todo extends StatefulWidget {
  static const routeName = '/todo';
  Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

final TaskController controller = Get.put(TaskController());

class _TodoState extends State<Todo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          title: Container(
            child: const Text(
              "Simple Todo Task!",
              style: TextStyle(fontSize: 30),
            ),
          ),
          centerTitle: true,
          elevation: 1.5,
        ),
        floatingActionButton: InkWell(
          onTap: () {
            Get.toNamed(AddTaskScreen.routeName);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.red,
            ),
            child: Icon(
              Icons.add_outlined,
              color: Colors.white,
            ),
            height: 50,
            width: 50,
          ),
        ),
        body: Obx(() => controller.taskList.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nothing here!!",
                    style: text.headline1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Image.network(
                      height: 150,
                      "https://media.tenor.com/V6viLE6UQPEAAAAd/john-travolta-where-are-you-guys.gif",
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    itemCount: controller.taskList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          EditTaskScreen.routeName,
                          arguments: {
                            'index': index,
                            'oldTask': controller.taskList[index].task,
                            'oldDescription':
                                controller.taskList[index].description,
                            'oldDueDate':
                                controller.taskList[index].taskDueCreated!
                          },
                        ),
                        child: TaskTile(
                          size: size,
                          text: text,
                          task: controller.taskList[index].task,
                          description: controller.taskList[index].description,
                          taskCreated: controller
                              .taskList[index].taskDueCreated!
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                          taskDueCreated: controller
                              .taskList[index].taskDueCreated!
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                          press: () {
                            controller.deleteTask(controller.taskList[index]);
                            setState(() {});
                          },
                        ),
                      );
                    }),
              )),
      ),
    );
  }
}
