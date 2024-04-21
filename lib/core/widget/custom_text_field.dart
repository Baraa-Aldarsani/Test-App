// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:test_baraa/core/constant.dart';

class CustomTextFromField extends StatelessWidget {
  final String hintText;
  final String icon;
  final TextInputType keyboardType;
  final dynamic onSaved;
  final dynamic validator;
  final dynamic onTap;
  final Color hintColor;
  final double fontSize;
  final bool obscureText;
  final bool readOnly;
  var controller;

  CustomTextFromField({
    super.key,
    this.hintText = '',
    this.icon = '',
    this.onSaved,
    this.onTap,
    this.controller,
    this.validator,
    this.hintColor = const Color.fromRGBO(29, 53, 87, 1),
    this.fontSize = 13,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5),
        child: TextFormField(
          readOnly: readOnly,
          
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Image.asset(icon),
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: fontSize,
              fontFamily: 'Playfair Display',
              // height: 1,
            ),
            border: const OutlineInputBorder(
              
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
          ),
          onSaved: onSaved,
          onTap: onTap,
          validator: validator,
          obscureText: obscureText,
          cursorColor: Colors.black,
        ),
      ),
    );
  }
}
