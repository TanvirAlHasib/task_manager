import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/api/ApiInstance.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/utils/validatorName.dart';
import 'package:task_manager/widgets/Text_form_field.dart';
import 'package:task_manager/widgets/filledButtonWidget.dart';
import 'package:task_manager/widgets/toast.dart';
import '../utils/colours.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colours.cardColor),
      appBar: myAppBar(),
      body: Container(
        padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20, top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Spacer(),
              Text("Add New Task", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Color(Colours.fontColor),
                fontWeight: FontWeight.w600
              ),),
              const SizedBox(
                height: 12,
              ),
              Text_form_field(textEditingController: titleEditingController,
                  labelText: "Task Title",
                  textInputType: TextInputType.text,
                  validationFor: Validatorname.name
              ),
              const SizedBox(
                height: 10,
              ),
              Text_form_field(textEditingController: descriptionEditingController,
                  labelText: "Task Description",
                  textInputType: TextInputType.text,
                  validationFor: Validatorname.description,
                maxLines: 6,
              ),
              const SizedBox(
                height: 30,
              ),
              FilledButtonWidget(formKey: _formKey, buttonText: "Create Task", action: () async{
                Response response = await ApiInstance.postData(Urls.createTaskUrl, {
                  "title": titleEditingController.text,
                  "description": descriptionEditingController.text,
                  "status": "New"
                });
                if(response.statusCode == 200 || response.statusCode == 201){
                  Toast.show(message: "Task creation successfully", context: context);
                  Navigator.pop(context, true);
                } else{
                  Toast.show(message: "Task creation failed", context: context);
                }
              },),
              Spacer(flex: 3,)
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
