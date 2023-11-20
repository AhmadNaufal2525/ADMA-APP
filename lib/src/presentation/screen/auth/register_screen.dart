import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/form_register_widget.dart';
import 'package:sima_app/src/utils/colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
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
                  const FormRegisterWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}