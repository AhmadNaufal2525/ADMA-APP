import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormFieldWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String text;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final bool isReadOnly;

  const TextFormFieldWidget({
    super.key,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    required this.onChanged,
    this.isReadOnly = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(text),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            readOnly: isReadOnly,
            initialValue: initialValue,
            onChanged: onChanged,
            validator: validator,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              filled: true,
              fillColor: const Color(0xffF3F3F3),
            ),
          ),
        ],
      ),
    );
  }
}
