import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/email_address_screen.dart';
import 'package:task_manager/screens/signup_screen.dart';
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
  final _formKey = GlobalKey<FormState>();

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
                child: Form(
                  key: _formKey,
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
                          if(_formKey.currentState!.validate()){
                            // another route will be here after authentication
                          }
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
                        height: 20,
                      ),
                      RichText(text: TextSpan(
                        text: "Forget password ?",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(Colours.fontColor),
                        ),
                        children: [
                          WidgetSpan(child: SizedBox(width: 5,)),
                          TextSpan(
                            text: "Click here..",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              decorationColor: Color(Colours.fontColor),
                              decorationThickness: 1,
                              decoration: TextDecoration.underline
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EmailAddressScreen(),));
                            }
                          )
                        ]
                      )),
                      const SizedBox(
                        height: 7,
                      ),
                      Text("or", style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Color(Colours.fontColor)
                      ),),
                      const SizedBox(
                        height: 7,
                      ),
                      RichText(text: TextSpan(
                          text: "Don't have account ?",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Color(Colours.fontColor),
                          ),
                          children: [
                            WidgetSpan(child: SizedBox(width: 5,)),
                            TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                                }
                            )
                          ]
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
