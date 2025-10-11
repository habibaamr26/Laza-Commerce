import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hint,
    this.isPassword = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle:const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.grey,
        ) ,
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.grey, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 14,
        ),
      ),
    );
  }
}
