import 'package:flutter/material.dart';
import '../utils/colours.dart';

class FilledButtonWidget extends StatelessWidget {
  const new({
    super.key,
    required this._formKey,
    required this.buttonText,
    this.action
  });

  final GlobalKey<FormState> _formKey;
  final String buttonText;
  final Function ? action;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(
            backgroundColor: Color(Colours.buttonColor),
            minimumSize: Size.fromHeight(55)
        ),
        onPressed: () {
          if(_formKey.currentState!.validate()){
            // another route will be here after authentication
          }
        }, child: Row(
      spacing: 8,
      crossAxisAlignment: .center,
      mainAxisAlignment: .center,
      children: [
        Text(buttonText, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600
        ),),
        Icon(Icons.arrow_forward_outlined, color: Colors.black87,)
      ],
    ));
  }
}