import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({this.hintText, this.onchanged,this.obsure=false});
  String? hintText;
  bool?obsure;
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obsure! ,
      
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        }
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
