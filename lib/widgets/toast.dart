import 'package:flutter/material.dart';
import 'package:task_manager/utils/colours.dart';

class Toast {
  static void show({required String message, required BuildContext context}){
    final SnackBar snackBar = SnackBar(
      content: Text(message, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Color(Colours.fontColor),
      ),),
      closeIconColor: Color(Colours.fontColor),
      showCloseIcon: true,
      backgroundColor: Color(Colours.backGroundColor),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}