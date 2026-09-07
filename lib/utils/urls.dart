class Urls {
  static String baseUrl = "https://task-manager-api.ostad.live/api/v1";
  static String loginUrl = "$baseUrl/Login";
  static String registrationUrl = "$baseUrl/Registration";
  static String createTaskUrl = "$baseUrl/createTask";
  static String taskStatusCountUrl = "$baseUrl/taskStatusCount";
  static String listTaskByStatus(String value) => "$baseUrl/listTaskByStatus/$value";
  static String deleteTask(String id) => "$baseUrl/deleteTask/$id";
}