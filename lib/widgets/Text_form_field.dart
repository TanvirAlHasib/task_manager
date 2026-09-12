import 'package:flutter/material.dart';
import 'package:task_manager/utils/validatorName.dart';
import '../utils/colours.dart';

class Text_form_field extends StatefulWidget {
  const Text_form_field({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.textInputType,
    required this.validationFor,
    this.maxLines
  });

  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String validationFor;
  final int? maxLines;

  @override
  State<Text_form_field> createState() => _TextFormFieldState();
}

class _TextFormFieldState extends State<Text_form_field> {
  bool _obscureText = true;

  bool get _isPassword => widget.validationFor.contains(Validatorname.pass);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: _isPassword ? 1 : widget.maxLines,
      obscureText: _isPassword ? _obscureText : false,
      cursorColor: Colors.white,
      controller: widget.textEditingController,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      keyboardType: widget.textInputType,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Color(Colours.fontColor)
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.grey
        ),
        fillColor: Color(Colours.backGroundColor),
        filled: true,
        suffixIcon: _isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
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
        if(widget.validationFor.contains(Validatorname.email)){
          RegExp regExp = RegExp(r"[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+");
          if(!regExp.hasMatch(value)){
            return "Enter valid email address";
          }
        } else if(_isPassword){
          RegExp regExp = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$");
          if(!regExp.hasMatch(value)){
            return "Enter strong password";
          }
        } else if(widget.validationFor.contains(Validatorname.otp)){
          RegExp regExp = RegExp(r"^\d{6}$");
          if(!regExp.hasMatch(value)){
            return "OTP is not valid";
          }
        } else if(widget.validationFor.contains(Validatorname.mobile)){
          RegExp regExp = RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");
          if(!regExp.hasMatch(value)){
            return "Enter valid phone number";
          }
        } else if(widget.validationFor.contains(Validatorname.name)){
          RegExp regExp = RegExp(r"^[A-Za-z]+(?:\s[A-Za-z]+)*$", unicode: true);
          if(!regExp.hasMatch(value)){
            return "Enter valid name";
          }
        } else if(widget.validationFor.contains(Validatorname.description)){
          RegExp regExp = RegExp(r"^.{10,500}$", unicode: true);
          if(!regExp.hasMatch(value)){
            return "Enter valid description";
          }
        } else if(widget.validationFor.contains(Validatorname.title)){
          RegExp regExp = RegExp(r"^(?!\s*$).{3,100}$", unicode: true, dotAll: true);
          if(!regExp.hasMatch(value)){
            return "Enter valid title";
          }
        }

        return null;
      },
    );
  }
}