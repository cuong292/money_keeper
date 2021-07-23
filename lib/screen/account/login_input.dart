import 'package:base_flutter/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    var inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: ConstColor.grayBlueC3C,
      ),
      borderRadius: BorderRadius.circular(8),
    );
    return TextField(
      controller: controller,
      maxLines: 1,
      minLines: null,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      textCapitalization: TextCapitalization.sentences,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        filled: true,
        isCollapsed: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: ConstColor.grayB9B,
        ),
        contentPadding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 6),
        fillColor: Colors.white,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
      ),
    );
  }
}
