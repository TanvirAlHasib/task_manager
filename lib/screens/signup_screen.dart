import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/colours.dart';
import '../utils/validatorName.dart';
import '../widgets/Text_form_field.dart';
import '../widgets/filledButtonWidget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colours.cardColor),
      appBar: myAppBar(),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          children: [
            Text("Join With Us", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Color(Colours.fontColor),
                fontWeight: FontWeight.w600
            )),
            const SizedBox(
              height: 6,
            ),
            Text("Create an account to begin your Task Management journey.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Color(Colours.fontColor),
            )),
            const SizedBox(
              height: 5,
            ),

            // start here input part
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text_form_field(labelText: "Email",
                      textInputType: TextInputType.emailAddress,
                      textEditingController: emailTextEditingController,
                      validationFor: Validatorname.email,),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Expanded(child: Text_form_field(labelText: "First Name",
                          textInputType: TextInputType.text,
                          textEditingController: firstNameTextEditingController,
                          validationFor: Validatorname.name,)),
                        Expanded(child: Text_form_field(labelText: "Last Name",
                          textInputType: TextInputType.text,
                          textEditingController: lastNameTextEditingController,
                          validationFor: Validatorname.name,)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text_form_field(labelText: "Phone",
                      textInputType: TextInputType.phone,
                      textEditingController: phoneTextEditingController,
                      validationFor: Validatorname.mobile,),
                    const SizedBox(
                      height: 10,
                    ),
                    Text_form_field(labelText: "Password",
                      textInputType: TextInputType.visiblePassword,
                      textEditingController: passTextEditingController,
                      validationFor: Validatorname.pass,),
                    const SizedBox(
                      height: 30,
                    ),
                    FilledButtonWidget(formKey: _formKey, buttonText: "Create Account", action: () {
                      // action will be here
                      Navigator.pop(context);
                    },),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(text: TextSpan(
                        text: "Already have account ?",
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
                                Navigator.pop(context);
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
          Text("Sign Up", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(Colours.fontColor),
              fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
