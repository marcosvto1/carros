import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode focusNext;

  AppText(
    this.label,
    this.hint, {
    this.password = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.focusNext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 25, color: Colors.blue),
      obscureText: password,
      validator: validator,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(
            fontSize: 25,
            color: Colors.grey,
          ),
          hintStyle: TextStyle(fontSize: 16),
          border: OutlineInputBorder()),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        FocusScope.of(context).requestFocus(focusNext);
      },
    );
  }
}
