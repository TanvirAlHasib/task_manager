import 'package:flutter/material.dart';

import '../utils/colours.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colours.cardColor),
      appBar: myAppBar(),
    );
  }

  // app bar
  AppBar myAppBar(){
    return AppBar(
      backgroundColor: Color(Colours.backGroundColor),
      elevation: 2,
      automaticallyImplyLeading: false,
      automaticallyImplyActions: false,
      centerTitle: true,
      title: Row(
        spacing: 10,
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(40),
              child: Image.asset("lib/assets/logo/logo_starDust.png", height: 40,)
          ),
          Text("New Task", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(Colours.fontColor),
              fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
