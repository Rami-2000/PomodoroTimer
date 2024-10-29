import 'package:flutter/material.dart';
import 'package:flutter_pomodoro_master/controllers/tasks_controller.dart';
import 'package:get/get.dart';

class TaskPage extends StatelessWidget {
  static const routeName = '/task';

  TaskPage({super.key});
  final TextEditingController _textEditingController = TextEditingController();
  final TasksController _taskController = Get.put(TasksController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: "Enter your task",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  _taskController.addTask(_textEditingController.text);
                  _textEditingController.clear();
                }
              },
              child: const Text('Add Task'),
            ),
            Expanded(
              child: Obx(() {
                if (_taskController.tasks.isEmpty) {
                  return const Center(child: Text('No tasks added.'));
                } else {
                  return ListView.builder(
                    itemCount: _taskController.tasks.length,
                    itemBuilder: (context, index) {
                      final task = _taskController.tasks[index];
                      return ListTile(
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            _taskController.toggleTaskCompletion(index);
                          },
                        ),
                        title: Text(
                          task.name,
                          style: TextStyle(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: Text('Stages: ${task.stages}'),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
