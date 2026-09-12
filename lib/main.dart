import 'package:flutter/material.dart';
import 'package:task_manager/screens/splash_screen.dart';
import 'package:task_manager/utils/notification_helper.dart';
import 'package:task_manager/utils/work_manager.dart';
import 'package:workmanager/workmanager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize();
  await Workmanager().initialize(WorkManager.callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    "task-count-notification-job",
    "taskCountNotification",
    frequency: Duration(minutes: 1)
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}
