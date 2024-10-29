import 'package:get/get.dart';

class TasksController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(String taskName) {
    tasks.add(Task(taskName));
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
  }

  void incrementTaskStages(int index) {
    tasks[index].stages++;
    tasks.refresh();
  }
}

class Task {
  String name;
  bool isCompleted;
  int stages;

  Task(this.name, {this.isCompleted = false, this.stages = 0});
}
