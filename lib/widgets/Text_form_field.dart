import 'package:flutter/material.dart';
import '../utils/colours.dart';

class Text_form_field extends StatelessWidget {
  const new({
    super.key,
    required this.textEditingController,
    required this.labelText,
    required this.textInputType
  });

  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          return "can not be empty";
        }
        return null;
      },
    );
  }
}