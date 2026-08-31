import 'package:flutter/material.dart';
import 'package:task_manager/utils/validatorName.dart';
import '../utils/colours.dart';

class Text_form_field extends StatelessWidget {
  const new({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.textInputType,
    required this.validationFor
  });

  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String validationFor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      controller: textEditingController,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      keyboardType: textInputType,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Color(Colours.fontColor)
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.grey
        ),
        fillColor: Color(Colours.backGroundColor),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12)
        ),
      ),
      validator: (value) {
        if(value == null || value.isEmpty){
          return "Field can not be empty";
        }
        if(validationFor.contains(Validatorname.email)){
          RegExp regExp = RegExp(r"[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+");
          if(!regExp.hasMatch(value)){
            return "Enter valid email address";
          }
        } else if(validationFor.contains(Validatorname.pass)){
          RegExp regExp = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$");
          if(!regExp.hasMatch(value)){
            return "Enter strong password";
          }
        } else if(validationFor.contains(Validatorname.otp)){
          RegExp regExp = RegExp(r"^\d{6}$");
          if(!regExp.hasMatch(value)){
            return "OTP is not valid";
          }
        } else if(validationFor.contains(Validatorname.mobile)){
          RegExp regExp = RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
          if(!regExp.hasMatch(value)){
            return "Enter valid phone number";
          }
        } else if(validationFor.contains(Validatorname.name)){
          RegExp regExp = RegExp(r"^[A-Za-z]+(?:\s[A-Za-z]+)*$");
          if(!regExp.hasMatch(value)){
            return "Enter valid name";
          }
        }

        return null;
      },
    );
  }
}