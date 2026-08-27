import 'package:flutter/material.dart';
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
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
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
          child: Image.asset("lib/assets/logo/logo.png", fit: BoxFit.cover, height: 300,),
        ),
      ),
    );
  }
}
