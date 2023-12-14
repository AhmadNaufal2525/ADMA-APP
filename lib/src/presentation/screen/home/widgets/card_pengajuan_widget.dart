import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/utils/colors.dart';

class CardPengajuanWidget extends StatelessWidget {
  final String text;
  final String date;
  final String status;

  const CardPengajuanWidget({
    super.key,
    required this.text,
    required this.date,
    required this.status,
  });

  Color getStatusTextColor() {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return const Color.fromRGBO(255, 225, 0, 1);
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        height: 130.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColor.primaryColor, AppColor.whiteColor],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                  color: AppColor.primaryColor,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/barang.png',
                    width: 100.0.w,
                    height: 100.0.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 14.0.h),
                      Text(
                        date,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      SizedBox(height: 12.0.h),
                      Text(
                        'Status : $status',
                        style: TextStyle(
                          color: getStatusTextColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
