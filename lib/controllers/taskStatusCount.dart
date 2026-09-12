import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_manager/api/ApiInstance.dart';
import 'package:task_manager/utils/notification_helper.dart';
import 'package:task_manager/utils/urls.dart';

class TaskStatusCount {
  static Future<bool> taskStatusCount() async{
    Response response = await ApiInstance.getData(Urls.taskStatusCountUrl);
    if(response.statusCode == 200 || response.statusCode == 201){
      final mapResponse = jsonDecode(response.body);
      int newCount = 0;
      int progressCount = 0;
      for(Map<String, dynamic> data in mapResponse["data"]){
        if(data["_id"] == "New"){
          newCount = data["sum"];
        } else if(data["_id"] == "Progress"){
          progressCount = data["sum"];
        }
      }

      if(newCount > 0 || progressCount > 0){
        await NotificationHelper.showNotification(
          "Task Remainder",
          "You have $newCount new, and $progressCount progress task"
        );
      } else {
        await NotificationHelper.showNotification(
          "Task Remainder",
          "It is time to plan your task!!"
        );
      }

      return true;

    }

    await NotificationHelper.showNotification(
        "Log in",
        "Log in and plan your task!!"
    );

    return true;
  }
}