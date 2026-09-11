import 'package:flutter/material.dart';
import 'package:task_manager/screens/splash_screen.dart';
import 'package:task_manager/utils/notification_helper.dart';

void main() {
  NotificationHelper.initialize();
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
