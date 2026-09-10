import 'package:flutter/material.dart';
import 'package:task_manager/screens/dashboard_screen.dart';
import 'package:task_manager/screens/profile_screen.dart';
import '../utils/colours.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Widget> screenList = [DashboardScreen(), ProfileScreen()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if(!didPop){
          setState(() {
            currentIndex -= 1;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Color(Colours.cardColor),
        appBar: myAppBar(),
        body: screenList[currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadiusGeometry.directional(
            topStart: Radius.circular(15),
            topEnd: Radius.circular(15)
          ),
          child: BottomNavigationBar(
            backgroundColor: Color(Colours.backGroundColor),
            elevation: 1,
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            selectedItemColor: Color(Colours.fontColor),
            showUnselectedLabels: false,
            unselectedItemColor: Color(Colours.secondaryFontColor),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: "Dashboard"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                activeIcon: Icon(Icons.person),
                label: "Profile"
              )
            ],
          ),
        ),
      ),
    );
  }

  // app bar
  AppBar myAppBar(){
    return AppBar(
      backgroundColor: Color(Colours.backGroundColor),
      automaticallyImplyLeading: false,
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
