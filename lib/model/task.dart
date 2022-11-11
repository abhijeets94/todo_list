// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  String task;
  DateTime taskCreated;
  DateTime? taskDueCreated;
  String? description;

  Task({
    required this.task,
    required this.taskCreated,
    this.taskDueCreated,
    this.description,
  });
}
