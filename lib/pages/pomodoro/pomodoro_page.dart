import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/pomodoro_controller.dart';
import '../settings/settings_page.dart';
import './widgets/clock_cap.dart';
import './widgets/main_body.dart';

class PomodoroPage extends GetView<PomodoroController> {
  static const routeName = '/pomodoro';

  const PomodoroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const MainBody(),
          Obx(
            () => AnimatedBuilder(
                animation: controller.animation.value,
                builder: (animContext, widget) {
                  return ClockCap(
                    barCount: 60,
                    progression: controller.animation.value.value,
                  );
                }),
          ),
          Obx(
            () => Visibility(
              visible: controller.canReset.value,
              child: Positioned(
                bottom: 20,
                left: 20,
                child: TextButton(
                  onPressed: controller.reset,
                  child: Column(
                    children: const [
                      Icon(
                        Icons.undo,
                        color: Colors.white70,
                      ),
                      Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsPage.routeName);
              },
              child: Column(
                children: const [
                  Icon(
                    Icons.settings,
                    color: Colors.white70,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                // Navigate to TaskPage
                Get.toNamed(TaskPage.routeName);
              },
              child: Icon(Icons.task),
              tooltip: 'Go to Task Page',
            ),
            SizedBox(height: 10), // Space between buttons
            FloatingActionButton(
              onPressed: () {
                // Action to add a new task
                Get.dialog(AddTaskDialog());
              },
              child: Icon(Icons.add),
              tooltip: 'Add Task',
            ),
            SizedBox(height: 10), // Space between buttons
            FloatingActionButton(
              onPressed: controller.status.value == PomodoroStatus.started
                  ? controller.stop
                  : controller.start,
              child: Icon(controller.status.value == PomodoroStatus.started
                  ? Icons.pause
                  : Icons.play_arrow),
              tooltip: 'Start/Stop Pomodoro',
            ),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class AddTaskDialog extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: TextField(
        controller: _taskController,
        decoration: InputDecoration(hintText: 'Enter your task'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_taskController.text.isNotEmpty) {
              // Add your task management logic here
              // For example, add the task to a list or storage
              Get.back();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class TaskPage extends StatelessWidget {
  static const routeName = '/task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Page'),
      ),
      body: Center(
        child: Text('Task Page Content Here', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
