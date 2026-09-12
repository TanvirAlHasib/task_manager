import 'package:task_manager/controllers/taskStatusCount.dart';
import 'package:workmanager/workmanager.dart';

class WorkManager {
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    bool status = false;
    Workmanager().executeTask((task, inputData) async {
      if(task == "taskCountNotification"){
        print("Background task: $task");
        status = await TaskStatusCount.taskStatusCount();
        return Future.value(status);
      }
      return Future.value(status);
    });
  }
}