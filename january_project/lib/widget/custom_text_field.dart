import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType keyType;
  final String labl;
  final String hint;
  final Widget preIcon;
  final Widget? sfxIcon;
  final bool obscureT;
  final String? Function(String?)? valid;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.keyType,
    required this.labl,
    required this.hint,
    required this.preIcon,
    this.sfxIcon,
    this.obscureT = false,
    this.valid,
    this.onChanged, 
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged, 
      validator: widget.valid,
      keyboardType: widget.keyType,
      obscureText: widget.obscureT,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        label: Text(widget.labl, style: const TextStyle(fontWeight: FontWeight.bold)),
        hintText: widget.hint, 
        prefixIcon: widget.preIcon,
        suffixIcon: widget.sfxIcon,
      ),
    );
  }
}