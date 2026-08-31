import 'package:flutter/material.dart';
import 'package:task_manager/screens/set_pass_screen.dart';
import '../utils/colours.dart';
import '../widgets/Text_form_field.dart';
import '../widgets/filledButtonWidget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  final TextEditingController pinEditingController = TextEditingController();
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
            children: [
              CircleAvatar(
                maxRadius: 38,
                backgroundColor: Color(Colours.backGroundColor),
                child: Icon(Icons.email, color: Color(Colours.buttonColor), size: 40,),
              ),
              const SizedBox(
                height: 9,
              ),
              Text("A 6 digit verification pin will send to your email address", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Color(Colours.fontColor)
              ),),
              const SizedBox(
                height: 20,
              ),
              Text_form_field(textEditingController: pinEditingController, labelText: "Enter 6 digits pin..", textInputType: TextInputType.number),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                    // here will be the action to resend code
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color(Colours.buttonColor)
                    ),
                    child: Text("Resend Code"))
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              FilledButtonWidget(formKey: _formKey, buttonText: "Verify", action: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SetPassScreen(),)),),
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
          Text("Verification", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(Colours.fontColor),
              fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}
