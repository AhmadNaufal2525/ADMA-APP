import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        minimumSize: Size(393.w, 60.h),
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide.none,
        ),
      ),
      label: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
      icon: icon != null ? icon! : const SizedBox(),
    );
  }
}
