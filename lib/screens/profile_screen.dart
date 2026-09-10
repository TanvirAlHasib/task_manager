import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/screens/dashboard_screen.dart';
import '../api/ApiInstance.dart';
import '../utils/colours.dart';
import '../utils/urls.dart';
import '../utils/validatorName.dart';
import '../widgets/Text_form_field.dart';
import '../widgets/filledButtonWidget.dart';
import '../widgets/toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController emailTextEditingController = TextEditingController();
  final TextEditingController firstNameTextEditingController = TextEditingController();
  final TextEditingController lastNameTextEditingController = TextEditingController();
  final TextEditingController passTextEditingController = TextEditingController();
  final TextEditingController phoneTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }
  
  // get profile details
  void getProfileDetails() async{
    Response response = await ApiInstance.getData(Urls.profileDetailsUrl);
    if(response.statusCode == 200){
      final mapData = jsonDecode(response.body);
      emailTextEditingController.text = mapData["data"][0]["email"];
      firstNameTextEditingController.text = mapData["data"][0]["firstName"];
      lastNameTextEditingController.text = mapData["data"][0]["lastName"];
      phoneTextEditingController.text = mapData["data"][0]["mobile"];
      passTextEditingController.text = mapData["data"][0]["password"];
      return;
    }
    Toast.show(message: "Something went wrong!!", context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colours.cardColor),
      appBar: myAppBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(),
              Text("Update Profile", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Color(Colours.fontColor),
                fontWeight: FontWeight.w600,
              ),),
              const SizedBox(
                height: 20,
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
              FilledButtonWidget(formKey: _formKey, buttonText: "Update Profile", action: () async{
                // api action
                Response response = await ApiInstance.postData(Urls.profileUpdateUrl, {
                  "email": emailTextEditingController.text,
                  "firstName": firstNameTextEditingController.text,
                  "lastName": lastNameTextEditingController.text,
                  "mobile": phoneTextEditingController.text,
                  "password": passTextEditingController.text
                });
                if(response.statusCode == 200 || response.statusCode == 201) {
                  Toast.show(message: "Profile update successful!!", context: context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen(),),
                    (route) => false,
                  );
                } else {
                  Toast.show(message: "Profile update unsuccessful!!", context: context);
                }
              },),
              Spacer(flex: 4,)
            ],
          ),
        ),
      ),
    );
  }

  // app bar
  // appbar start here
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
