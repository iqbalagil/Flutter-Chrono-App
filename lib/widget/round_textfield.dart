import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_akhir/common/color_common.dart';

class RoundTextField extends StatelessWidget {
final TextEditingController? controller;
final TextInputType? keyboardType;
final String hitText;
final IconData icon;
final Widget? rigtIcon;
final bool obscureText;
final EdgeInsets? margin;
  const RoundTextField({super.key, required this.icon, this.controller,this.keyboardType, required this.hitText,this.margin,this.obscureText = false,this.rigtIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField( // Use TextFormField
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(color: TColor.gray, fontSize: 13), // Customize text style
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: hitText,
        hintStyle: TextStyle(color: TColor.gray, fontSize: 13),
        prefixIcon: Icon(icon), // Use icon directly
        suffixIcon: rigtIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none, // Hide default border
        ),
        filled: true,
        fillColor: TColor.white, // Set background color
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: TColor.secondary1, // Color when focused
            width: 2.0,
          ),
        ),
      ),
    );
  }
}