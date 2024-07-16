import 'package:flutter/material.dart';
import 'package:learnfirebase/screens/login_page.dart';



class CustomFormField extends StatelessWidget {
  final String hintText;
  final double height;
  final RegExp validationRegEx;
  final bool obsecureText;
  final void Function(String?) onSaved;

  const CustomFormField(
      {super.key,
    required this.hintText,
    required this.height,
    required this.validationRegEx,
        this.obsecureText = false,
        required this.onSaved,
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onSaved: onSaved,
        obscureText: obsecureText,
        validator: (value){
          if (value != null && validationRegEx.hasMatch(value)) {
            return null;
          }
          return "Enter a valid ${hintText.toLowerCase()}";
        },
        decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder()
        ),
      ),
    );
  }
}