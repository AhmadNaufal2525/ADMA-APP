import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/presentation/router/routes.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_password_textfield_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_textfield_widget.dart';

class FormForgotPasswordWidget extends StatefulWidget {
  const FormForgotPasswordWidget({super.key});

  @override
  State<FormForgotPasswordWidget> createState() =>
      _FormForgotPasswordWidgetState();
}

class _FormForgotPasswordWidgetState extends State<FormForgotPasswordWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  late String confirmPassword;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    animation = Tween(begin: -5.0, end: 5.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reset Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Silahkan isi data sesuai akun yang telah didaftarkan',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Center(
                child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    'assets/images/forgot_pass.png',
                    width: 160.w,
                    height: 160.h,
                  ),
                ),
              );
            },
          ),
          Text(
            'Email',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextFieldWidget(
            onChanged: (value) {
              email = value.trim();
            },
            icon: Icons.email_rounded,
            hintText: 'contoh123@sucofindo.com',
            validator: (value) {
              final emailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
              if (value == null || value.isEmpty) {
                return 'Email Tidak Boleh Kosong!';
              } else if (!emailRegex.hasMatch(value)) {
                return 'Masukkan Alamat Email Dengan Benar!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Password Baru',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomPasswordTextFieldWidget(
            hintText: 'Password Baru',
            onChanged: (value) {
              password = value.trim();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Password Anda';
              } else if (value.length < 6) {
                return 'Password harus terdiri dari 6 karakter!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Konfirmasi Password',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomPasswordTextFieldWidget(
            hintText: 'Konfirmasi Password',
            onChanged: (value) {
              confirmPassword = value.trim();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Password Anda';
              } else if (value.length < 6) {
                return 'Password harus terdiri dari 6 karakter!';
              } else if (confirmPassword != password) {
                return 'Password Tidak Sama!';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40.h,
          ),
          CustomButtonWidget(
            text: 'Submit',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pushReplacementNamed(Routes.initScreen);
              }
            },
          ),
        ],
      ),
    );
  }
}
