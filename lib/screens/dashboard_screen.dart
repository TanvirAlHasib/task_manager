import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/api/ApiInstance.dart';
import 'package:task_manager/models/TaskCountModel.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/utils/colours.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widgets/filledButtonWidget.dart';
import 'package:task_manager/widgets/toast.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<Data>> taskQuery;
  final List<String> statusList = ["New", "Progress", "Completed", "Canceled"];
  final _formKey = GlobalKey<FormState>();
  final List<TaskCountModel> taskCountList = [];

  @override
  void initState() {
    super.initState();
    taskQuery = getTaskByStatus("New");
    getTaskStatusCount();
  }

  //get task by status
  Future<List<Data>> getTaskByStatus(String status) async{
    Response response = await ApiInstance.getData(Urls.listTaskByStatus(status));
    final List<Data> tasks = [];
    if(response.statusCode == 200 || response.statusCode == 201){
      final mapResponse = jsonDecode(response.body);
      for(Map<String, dynamic> data in mapResponse["data"]){
        tasks.add(Data.fromJson(data));
      }
    } else if(response.statusCode == 429){
      Toast.show(message: "Too many request wait a little bit!!", context: context);
    }else {
      Toast.show(message: "Error fetching task!!", context: context);
    }
    return tasks;
  }

  //get task count
  Future<void> getTaskStatusCount() async{
    Response response = await ApiInstance.getData(Urls.taskStatusCountUrl);
    taskCountList.clear();
    if(response.statusCode == 200 || response.statusCode == 201){
      final mapResponse = jsonDecode(response.body);
      for(Map<String, dynamic> data in mapResponse["data"]){
        taskCountList.add(TaskCountModel.fromJson(data));
      }
    } else if(response.statusCode == 429){
      Toast.show(message: "Too many request wait a little bit!!", context: context);
    }else {
      Toast.show(message: "Error fetching task count!!", context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colours.cardColor),
      appBar: myAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text("Overview", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Color(Colours.fontColor),
              fontWeight: FontWeight.w600
            ),),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 9,
                children: [
                  TaskStatus(
                    icon: Icons.note_alt,
                    status: "New(12)",
                    foreGroundColor: Colors.blue.shade800,
                    backGroundColor: Colors.blue.shade50,
                    action: () {
                      setState(() {
                        taskQuery = getTaskByStatus("New");
                      });
                    },
                  ),
                  TaskStatus(
                    icon: Icons.cached,
                    status: "In Progress(3)",
                    foreGroundColor: Color(Colours.statusProgressForeGroundColor),
                    backGroundColor: Color(Colours.statusProgressBackGroundColor),
                    action: () {
                      setState(() {
                        taskQuery = getTaskByStatus("Progress");
                      });
                    },
                  ),
                  TaskStatus(
                    icon: Icons.task_alt,
                    status: "Completed(20)",
                    foreGroundColor: Colors.green.shade800,
                    backGroundColor: Colors.green.shade50,
                    action: () {
                      setState(() {
                        taskQuery = getTaskByStatus("Completed");
                      });
                    },
                  ),
                  TaskStatus(
                    icon: Icons.cancel_presentation,
                    status: "Canceled(2)",
                    foreGroundColor: Colors.red.shade800,
                    backGroundColor: Colors.red.shade50,
                    action: () {
                      setState(() {
                        taskQuery = getTaskByStatus("Canceled");
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Text("Your Tasks", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Color(Colours.fontColor),
              fontWeight: FontWeight.w600
            ),),
            const SizedBox(
              height: 17,
            ),
            Expanded(
              child: FutureBuilder(future: taskQuery, builder: (context, snapshot) {

                // if data is loading
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(Color(Colours.buttonColor)),
                      backgroundColor: Color(Colours.backGroundColor),
                      strokeWidth: 3,
                      strokeAlign: 2,
                    ),
                  );
                }

                // if there is no data or empty
                if(!snapshot.hasData || snapshot.data!.isEmpty){
                  return Center(
                      child: Text("No data yet!!", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Color(Colours.fontColor),
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),),);
                }

                // if data is available
                final taskList = snapshot.data!;
                return ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 25),
                      decoration:BoxDecoration(
                          color: Color(Colours.backGroundColor),
                          borderRadius: BorderRadiusGeometry.circular(15)
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              Text(taskList[index].title!, style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Color(Colours.fontColor),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600
                              ),),
                              TaskStatus(
                                status: taskList[index].status!,
                                icon: SetAccordingToStatus.getIcon(taskList[index].status!),
                                backGroundColor: SetAccordingToStatus.getBackGroundColor(taskList[index].status!),
                                foreGroundColor: SetAccordingToStatus.getForeGroundColor(taskList[index].status!),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            taskList[index].description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Color(Colours.secondaryFontColor)
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if(mounted){
                                      getPopUp(
                                        context: context,
                                        title: "Delete!!",
                                        content: "Do you want to delete the task ??",
                                        failToast: "Delete unsuccessful!!",
                                        successToast: "Delete successful!!",
                                        action: () async => await ApiInstance.getData(Urls.deleteTask(taskList[index].sId!)),
                                      );
                                    }
                                  },
                                  style: IconButton.styleFrom(
                                      foregroundColor: Colors.red.shade900
                                  ),
                                  icon: Icon(Icons.delete)
                              ),
                              IconButton(
                                  onPressed: () {
                                    //changing to menu entries
                                    final List<DropdownMenuEntry<String>> statusEntries = statusList.map((status) {
                                      return DropdownMenuEntry<String>(
                                        value: status,
                                        label: status,
                                        style: ButtonStyle(
                                          foregroundColor: WidgetStatePropertyAll(
                                            Colors.white,
                                          ),
                                        ),
                                      );
                                    }).toList();

                                    String ? selectedStatus = statusList.first;

                                    showModalBottomSheet(
                                      context: context,
                                      isDismissible: true,
                                      isScrollControlled: true,
                                      elevation: 2,
                                      builder: (context) {
                                        return Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context).size.height * 0.5 + MediaQuery.of(context).viewInsets.bottom,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Color(Colours.cardColor),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                          ),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                Text("Update Task Status", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                  color: Color(Colours.fontColor),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600
                                                ),),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                DropdownMenu(
                                                  width: double.infinity,
                                                  keyboardType: TextInputType.text,
                                                  initialSelection: statusList.first,
                                                  menuStyle: MenuStyle(
                                                    backgroundColor: WidgetStatePropertyAll(Color(Colours.cardColor))
                                                  ),
                                                  textStyle: TextStyle(
                                                    color: Color(Colours.fontColor)
                                                  ),
                                                  enableSearch: true,
                                                  dropdownMenuEntries: statusEntries,
                                                  onSelected: (value) {
                                                    setState(() {
                                                      selectedStatus = value;
                                                    });
                                                  },
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                FilledButtonWidget(formKey: _formKey, buttonText: "Confirm", action: () async {
                                                  // here api operation
                                                  Response response = await ApiInstance.getData(Urls.updateTaskStatus(taskList[index].sId!, selectedStatus!));
                                                  Navigator.pop(context);
                                                  if(response.statusCode == 200){
                                                    final mapResponse = jsonDecode(response.body);
                                                    if(mapResponse["data"]["modifiedCount"] == 1){
                                                      Toast.show(message: "Status updated successfully!!", context: context);
                                                      setState(() {
                                                        taskQuery = getTaskByStatus(selectedStatus!);
                                                        getTaskStatusCount();
                                                      });
                                                    } else{
                                                      Toast.show(message: "Selected same status", context: context);
                                                    }
                                                  } else{
                                                    Toast.show(message: "Something went wrong!!", context: context);
                                                  }
                                                },),
                                              ],
                                            ),
                                          ),
                                        );
                                    },);
                                  },
                                  style: IconButton.styleFrom(
                                      foregroundColor: Colors.green.shade800
                                  ),
                                  icon: Icon(Icons.edit)
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },);
              },)
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () async{
        // go to the add new task screen
        final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen(),));
        if(result == true){
          setState(() {
            taskQuery = getTaskByStatus("New");
          });
        }
      }, 
        backgroundColor: Color(Colours.buttonColor),
        child: Icon(Icons.add_task, color: Colors.black,),
      ),

    );
  }

  // appbar start here
  AppBar myAppBar(){
    return AppBar(
      backgroundColor: Color(Colours.backGroundColor),
      title: Row(
        mainAxisSize: .min,
        spacing: 8,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(50),
            child: Image.asset("lib/assets/logo/logo_starDust.png", height: 48,)
          ),
          Column(
            mainAxisAlignment:.center,
            crossAxisAlignment: .start,
            children: [
              Text("Welcome back,", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Color(Colours.fontColor)
              ),),
              Text("Tanvir Al Hasib", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Color(0XFFA1B9F0),
                  fontWeight: FontWeight.w600
              ),),
            ],
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () {  }, icon: Icon(Icons.notifications, color: Color(Colours.fontColor)),)
      ],
      actionsPadding: const EdgeInsets.only(right: 2),
    );
  }

  // show dialog
  void getPopUp({
    required BuildContext context,
    required String title,
    required String content,
    required Function action,
    required String successToast,
    required String failToast,
  }){
    showDialog(context: context, barrierDismissible: true, builder: (context) {
      return AlertDialog.adaptive(
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.red.shade900,
            fontWeight: FontWeight.w600
        ),),
        backgroundColor: Color(Colours.backGroundColor),
        content: Text(content, style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: Color(Colours.secondaryFontColor),
        ),),
        actions: [
          TextButton(onPressed: () async {
            Response response = await action.call();
            if(response.statusCode == 200){
              setState(() {
                taskQuery = getTaskByStatus("New");
              });
              Toast.show(message: successToast, context: context);
            } else{
              Toast.show(message: failToast, context: context);
            }
            Navigator.pop(context);
          }, child: Text("Yes", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Color(Colours.fontColor),
          ),)),

          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("No", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Color(Colours.fontColor),
          ),)),
        ],
      );
    },);
  }
}

// task status widget
class TaskStatus extends StatelessWidget {
  const new({
    super.key,
    required this.status,
    required this.icon,
    required this.backGroundColor,
    required this.foreGroundColor,
    this.action
  });

  final String status;
  final IconData icon;
  final Color backGroundColor;
  final Color foreGroundColor;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(action != null){
          action?.call();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadiusGeometry.circular(12),
          border: BoxBorder.all(
            color: Colors.grey.shade600,
            strokeAlign: BorderSide.strokeAlignOutside,
            width: 1
          ),
        ),
        child: Row(
          spacing: 5,
          mainAxisSize: .min,
          children: [
            Icon(icon, color: foreGroundColor, size: 18,),
            Text(status, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: foreGroundColor
            ),)
          ],
        ),
      ),
    );
  }
}

// set background, icon according to status
class SetAccordingToStatus{

  // get icon
  static IconData getIcon(String status){
    if(status.contains("New")){
      return Icons.note_alt;
    } else if(status.contains("Progress")){
      return Icons.cached;
    } else if(status.contains("Canceled")){
      return Icons.cancel_presentation;
    }
    return Icons.task_alt;
  }

  // get background color
  static Color getBackGroundColor(String status){
    if(status.contains("New")){
      return Colors.blue.shade50;
    } else if(status.contains("Progress")){
      return Color(Colours.statusProgressBackGroundColor);
    } else if(status.contains("Canceled")){
      return Colors.red.shade50;
    }
    return Colors.green.shade50;
  }

  // get background color
  static Color getForeGroundColor(String status){
    if(status.contains("New")){
      return Colors.blue.shade800;
    } else if(status.contains("Progress")){
      return Color(Colours.statusProgressForeGroundColor);
    } else if(status.contains("Canceled")){
      return Colors.red.shade800;
    }
    return Colors.green.shade800;
  }
}
