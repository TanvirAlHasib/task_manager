import 'package:flutter/material.dart';
import 'package:task_manager/utils/colours.dart';

import '../widgets/Text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colours.backGroundColor),
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(120),
                child: Image.asset("lib/assets/logo/logo_starDust.png", height: 120,)
              ),
              const SizedBox(
                height: 20,
              ),
              Text("Task Manager", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Color(Colours.fontColor),
                fontWeight: FontWeight.w600
              )),
              const SizedBox(
                height: 6,
              ),
              Text("Navigate your Task universe", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Color(Colours.fontColor),
              )),
              const SizedBox(
                height: 30,
              ),

              // start here input part
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Color(Colours.cardColor),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    Text("Sign In", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Color(Colours.fontColor)
                    ),),
                    const SizedBox(
                      height: 20,
                    ),
                    Text_form_field(labelText: "Email", textInputType: TextInputType.emailAddress, textEditingController: emailTextEditingController,),
                    const SizedBox(
                      height: 15,
                    ),
                    Text_form_field(labelText: "password", textInputType: TextInputType.text, textEditingController: passTextEditingController,),
                    const SizedBox(
                      height: 35,
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(Colours.buttonColor),
                        minimumSize: Size.fromHeight(55)
                      ),
                      onPressed: () {

                    }, child: Row(
                      spacing: 8,
                      crossAxisAlignment: .center,
                      mainAxisAlignment: .center,
                      children: [
                        Text("Sign In", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600
                        ),),
                        Icon(Icons.arrow_forward_outlined, color: Colors.black87,)
                      ],
                    )),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
