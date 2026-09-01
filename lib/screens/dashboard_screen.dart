import 'package:flutter/material.dart';
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
                  TaskStatus(icon: Icons.note_alt, status: "New(12)",),
                  TaskStatus(icon: Icons.cached, status: "In Progress(3)",),
                  TaskStatus(icon: Icons.cancel_presentation, status: "Canceled(2)",),
                  TaskStatus(icon: Icons.task_alt, status: "Completed(20)",),
                ],
              ),
            ),
          ],
        ),
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
    required this.icon
  });

  final String status;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(
          color: Color(Colours.backGroundColor),
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
            Icon(icon, color: Color(Colours.secondaryFontColor), size: 18,),
            Text(status, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Color(Colours.secondaryFontColor)
            ),)
          ],
        ),
      ),
    );
  }
}
