import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icon/notfound.png',
          width: 100.w,
          height: 100.h,
        ),
        SizedBox(
          height: 14.h,
        ),
        Text(
          'Pengajuan Tidak Ditemukan',
          style: TextStyle(fontSize: 16.sp),
        )
      ],
    );
  }
}
