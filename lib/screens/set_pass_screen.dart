import 'package:flutter/material.dart';
import 'package:task_manager/screens/login_screen.dart';
import 'package:task_manager/utils/validatorName.dart';
import 'package:task_manager/widgets/toast.dart';
import '../utils/colours.dart';
import '../widgets/Text_form_field.dart';
import '../widgets/filledButtonWidget.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({super.key});

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {

  final TextEditingController passEditingController = TextEditingController();
  final TextEditingController confirmPassEditingController = TextEditingController();
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
              Text("Set Password", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Color(Colours.fontColor),
                  fontWeight: FontWeight.w600
              )),
              Text("Your new password must be unique and contain at least 8 characters.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Color(Colours.fontColor)
              ),),
              const SizedBox(
                height: 5,
              ),
              Text_form_field(textEditingController: passEditingController, labelText: "password", textInputType: TextInputType.visiblePassword, validationFor: Validatorname.pass,),
              Text_form_field(textEditingController: confirmPassEditingController, labelText: "confirm password", textInputType: TextInputType.visiblePassword, validationFor: Validatorname.pass,),
              const SizedBox(
                height: 5,
              ),
              FilledButtonWidget(formKey: _formKey, buttonText: "Confirm",action: () {
                if(passEditingController.text == confirmPassEditingController.text){
                  // navigate to login page
                  Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,
                  );
                }
                Toast.show(message: "Password did not match", context: context);
              },),
              const SizedBox(
                height: 1,
              ),
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
