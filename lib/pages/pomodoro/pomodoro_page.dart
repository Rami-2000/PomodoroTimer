import 'package:flutter_pomodoro_master/pages/tasks/task_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/pomodoro_controller.dart';
import '../settings/settings_page.dart';
import './widgets/clock_cap.dart';
import './widgets/main_body.dart';

class PomodoroPage extends GetView<PomodoroController> {
  static const routeName = '/pomodoro';

  const PomodoroPage({super.key});

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
                  child: const Column(
                    children: [
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
                Get.toNamed(SettingsPage.routeName);
              },
              child: const Column(
                children: [
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
              tooltip: 'Go to Task Page',
              child: const Icon(Icons.task),
            ),
            const SizedBox(height: 10), // Space between buttons
            FloatingActionButton(
              onPressed: controller.status.value == PomodoroStatus.started
                  ? controller.stop
                  : controller.start,
              tooltip: 'Start/Stop Pomodoro',
              child: Icon(controller.status.value == PomodoroStatus.started
                  ? Icons.pause
                  : Icons.play_arrow),
            ),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
