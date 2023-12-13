import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormAsetButtonWidget extends StatelessWidget {
  final String icon;
  final Color backgroundColor;
  final String label;
  final VoidCallback onTap;

  const FormAsetButtonWidget({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        height: 80.h,
        width: 160.w,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: Image.asset(
                  icon,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
