import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sima_app/src/datasource/auth_remote_datasource.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_password_textfield_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_textfield_widget.dart';
import 'package:sima_app/src/utils/colors.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({super.key});

  @override
  State<FormRegisterWidget> createState() => _FormRegisterWidgetState();
}

class _FormRegisterWidgetState extends State<FormRegisterWidget>
    with SingleTickerProviderStateMixin {
  final AuthRemoteDataSource authDataSource = AuthRemoteDataSource();
  late AnimationController controller;
  late Animation<double> animation;
  final formKey = GlobalKey<FormState>();
  late String username;
  late String email;
  late String password;
  bool isLoading = false;

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

  void signUp(String email, String password, String username) async {
    setState(() {
      isLoading = true;
    });
    await authDataSource.signUp(context, email, password, username);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: isLoading ? 0.5 : 1.0,
          child: AbsorbPointer(
            absorbing: isLoading,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Silahkan isi kelengkapan akun',
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
                              'assets/images/register.png',
                              width: 160.w,
                              height: 160.h,
                            ),
                          ),
                        );
                      },
                    ),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFieldWidget(
                      onChanged: (value) {
                        username = value.trim();
                      },
                      icon: Icons.person_2,
                      hintText: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username Tidak Boleh Kosong!';
                        } else if (value.length < 8) {
                          return 'Username harus terdiri dari 8 karakter!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextFieldWidget(
                      onChanged: (value) {
                        email = value.trim();
                      },
                      icon: Icons.email_rounded,
                      hintText: 'Email',
                      validator: (value) {
                        final emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
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
                      'Password',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomPasswordTextFieldWidget(
                      hintText: 'Password',
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
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text:
                            'Dengan mendaftarkan akun, anda telah menyetujui untuk menerima ',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: 'Privasi dan Kebijakan Sucofindo',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: GoogleFonts.openSans().fontFamily,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomButtonWidget(
                      text: 'Register',
                      textColor: Colors.white,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          signUp(email, password, username);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Center(
              child: Container(
                color: Colors.transparent,
                child: SpinKitFadingFour(
                  color: AppColor.primaryColor,
                  size: 50.0.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
