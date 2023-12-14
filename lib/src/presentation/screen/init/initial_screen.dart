import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/presentation/router/routes.dart';
import 'package:sima_app/src/utils/colors.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    animation = Tween<double>(begin: -5.0, end: 5.0).animate(controller);
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity.w,
            child: Image.asset(
              'assets/images/ilustrator.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140.w,
                    height: 140.h,
                    child: Image.asset(
                      'assets/images/logo.png',
                      color: AppColor.primaryColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Selamat Datang di',
                    style: TextStyle(color: AppColor.greyColor, fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Aset Dashboard Management Application',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Ajukan peminjaman dan pengembalian aset di Sucofindo. Daftarkan akun dan ajukan peminjaman atau pengembalian aset.',
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14.sp,
                      height: 2,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Center(
                        child: Transform.translate(
                          offset: Offset(0, animation.value),
                          child: Image.asset(
                            'assets/images/box.png',
                            fit: BoxFit.contain,
                            width: 160.w,
                            height: 160.h,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.registerScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(160.w, 60.h),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0.r,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: AppColor.primaryColor,
                              size: 26.sp,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.loginScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(160.w, 60.h),
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0.r,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              color: Colors.white,
                              size: 26.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70.h,
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Sucofindo All Right Reserved @2023',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
