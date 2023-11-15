import 'package:flutter/material.dart';

class CustomPasswordTextFieldWidget extends StatefulWidget {
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final TextEditingController? controller;

  const CustomPasswordTextFieldWidget(
      {super.key,
      required this.hintText,
      this.validator,
      required this.onChanged,
      this.initialValue,
      this.controller});

  @override
  State<CustomPasswordTextFieldWidget> createState() =>
      _CustomPasswordTextFieldWidgetState();
}

class _CustomPasswordTextFieldWidgetState
    extends State<CustomPasswordTextFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.black,
          size: 18,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
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
