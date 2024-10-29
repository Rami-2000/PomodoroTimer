import 'package:flutter/material.dart';
import 'package:flutter_pomodoro_master/controllers/pomodoro_binding.dart';
import 'package:flutter_pomodoro_master/controllers/settings_binding.dart';
import 'package:flutter_pomodoro_master/pages/pomodoro/pomodoro_page.dart';
import 'package:flutter_pomodoro_master/pages/settings/settings_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../controllers/pomodoro_controller.dart';
void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          page: () => PomodoroPage(),
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
          page: () => TaskPage(),
        ),
      ],
      initialRoute: PomodoroPage.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
