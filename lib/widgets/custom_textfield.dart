import 'package:flutter/material.dart';
import 'package:hackathon/widgets/widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
        required this.hint,
        this.obscureText = false,
        this.controller,
        this.keyboardType,
        this.maxLines = 1,
        required this.icon,
      })
      : super(key: key);

  final String hint;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(231, 231, 231, 1),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 12,
          )
        ],
      ),
      child: TextFormField(
        cursorColor: Colors.white,
        maxLines: maxLines,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          prefixIcon: icon,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
              fontSize: 20, color: iconColor),
        ),
      ),
    );
  }
}
