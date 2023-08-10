import 'package:flutter/material.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({
    super.key,
    required this.labelText,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
  });
  final String labelText;
  final IconData? prefixIcon;
  final bool? obscureText;
  final IconData? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        prefixIconColor:
            prefixIcon != null ? Theme.of(context).colorScheme.primary : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        suffixIconColor: suffixIcon != null ? Colors.red : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: labelText,
      ),
    );
  }
}
