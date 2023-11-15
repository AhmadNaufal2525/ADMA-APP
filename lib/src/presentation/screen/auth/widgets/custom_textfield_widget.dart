import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final bool isReadOnly;
  const CustomTextFieldWidget({
    super.key,
    required this.onChanged,
    required this.icon,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.initialValue,
    this.controller,
    required this.isReadOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      initialValue: initialValue,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: hintText,
        hintText: hintText,
         hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
          size: 18,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
