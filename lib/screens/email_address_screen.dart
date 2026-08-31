import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/screens/verification_screen.dart';
import 'package:task_manager/utils/colours.dart';
import 'package:task_manager/utils/validatorName.dart';
import 'package:task_manager/widgets/Text_form_field.dart';
import '../widgets/filledButtonWidget.dart';

class EmailAddressScreen extends StatefulWidget {
  const EmailAddressScreen({super.key});

  @override
  State<EmailAddressScreen> createState() => _EmailAddressScreenState();
}

class _EmailAddressScreenState extends State<EmailAddressScreen> {

  final TextEditingController emailEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colours.cardColor),
      appBar: myAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 8,
            children: [
              Text("Your Email Address", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Color(Colours.fontColor),
                  fontWeight: FontWeight.w600
              )),
              Text("A 6 digit verification pin will send to your email address", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Color(Colours.fontColor)
              ),),
              const SizedBox(
                height: 5,
              ),
              Text_form_field(textEditingController: emailEditingController, labelText: "Email", textInputType: TextInputType.emailAddress, validationFor: Validatorname.email,),
              const SizedBox(
                height: 5,
              ),
              FilledButtonWidget(formKey: _formKey, buttonText: "Send OTP",action: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen(),)),),
              const SizedBox(
                height: 1,
              ),
              RichText(text: TextSpan(
                  text: "have account ?",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Color(Colours.fontColor),
                  ),
                  children: [
                    WidgetSpan(child: SizedBox(width: 5,)),
                    TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
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
          Text("Task Manager", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(Colours.fontColor),
              fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}

