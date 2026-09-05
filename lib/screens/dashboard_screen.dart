import 'package:flutter/material.dart';
import 'package:task_manager/screens/add_task_screen.dart';
import 'package:task_manager/utils/colours.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                    foreGroundColor: Color(Colours.secondaryFontColor),
                    backGroundColor: Color(Colours.backGroundColor),
                  ),
                  TaskStatus(
                    icon: Icons.cached,
                    status: "In Progress(3)",
                    foreGroundColor: Color(Colours.secondaryFontColor),
                    backGroundColor: Color(Colours.backGroundColor),
                  ),
                  TaskStatus(
                    icon: Icons.cancel_presentation,
                    status: "Canceled(2)",
                    foreGroundColor: Color(Colours.secondaryFontColor),
                    backGroundColor: Color(Colours.backGroundColor),
                  ),
                  TaskStatus(
                    icon: Icons.task_alt,
                    status: "Completed(20)",
                    foreGroundColor: Color(Colours.secondaryFontColor),
                    backGroundColor: Color(Colours.backGroundColor),
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
              child: ListView.builder(
                itemCount: 7,
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
                          Text("Title", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: Color(Colours.fontColor),
                              fontSize: 22,
                              fontWeight: FontWeight.w600
                          ),),
                          TaskStatus(
                            status: "In Progress",
                            icon: Icons.cached,
                            backGroundColor: Color(Colours.statusProgressBackGroundColor),
                            foreGroundColor: Color(Colours.statusProgressForeGroundColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Re-align communication arrays on sector 7 to ensure optimal data throughput with don't know what",
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
                            onPressed: () { },
                            style: IconButton.styleFrom(
                              foregroundColor: Colors.red.shade900
                            ),
                            icon: Icon(Icons.delete)
                          ),
                          IconButton(
                            onPressed: () { },
                            style: IconButton.styleFrom(
                              foregroundColor: Colors.green.shade900
                            ),
                            icon: Icon(Icons.edit)
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        // go to the add new task screen
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen(),));
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
}

// task status widget
class TaskStatus extends StatelessWidget {
  const new({
    super.key,
    required this.status,
    required this.icon,
    required this.backGroundColor,
    required this.foreGroundColor
  });

  final String status;
  final IconData icon;
  final Color backGroundColor;
  final Color foreGroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { },
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
