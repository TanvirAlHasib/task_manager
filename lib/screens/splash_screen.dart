import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/screens/dashboard_screen.dart';
import 'package:task_manager/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    loadNextScreen();
    super.initState();
  }

  Future loadNextScreen() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token") ?? "";
    await Future.delayed(Duration(seconds: 3), () {
      if(token.isEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen(),));
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: const [
              Color(0XFF0D1320),
              Color(0XFF151B2A)
            ],
            tileMode: TileMode.mirror
          )
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(200),
              child: Image.asset("lib/assets/logo/logo_starDust.png", fit: BoxFit.cover, height: 180,)),
        ),
      ),
    );
  }
}
