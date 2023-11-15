import 'package:flutter/material.dart';
import 'package:sima_app/src/utils/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? textColor;
  final Widget? icon;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(370, 60),
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide.none,
        ),
      ),
      label: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      icon: icon != null ? icon! : const SizedBox(),
    );
  }
}
