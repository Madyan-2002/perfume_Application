import 'package:flutter/material.dart';
import 'package:january_project/styles/color_class.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  const InputField({
    super.key,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: ColorClass.bgAdmin,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}