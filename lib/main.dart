import 'package:flutter_pomodoro_master/controllers/tasks_binding.dart';
import 'package:flutter_pomodoro_master/pages/tasks/task_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'controllers/settings_binding.dart';
import 'controllers/pomodoro_binding.dart';
import 'pages/settings/settings_page.dart';
import 'pages/pomodoro/pomodoro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pomodoro',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
      ),
      getPages: [
        GetPage(
          name: PomodoroPage.routeName,
          page: () => const PomodoroPage(),
          bindings: [
            PomodoroBinding(),
            SettingsBinding(),
          ],
        ),
        GetPage(
          name: SettingsPage.routeName,
          page: () => const SettingsPage(),
          binding: SettingsBinding(),
        ),
        GetPage(
          name: TaskPage.routeName,
          page: () =>  TaskPage(),
          binding: TasksBinding(),
        ),
      ],
      initialRoute: PomodoroPage.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
