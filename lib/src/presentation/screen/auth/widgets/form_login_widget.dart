import 'package:flutter/material.dart';
import 'package:sima_app/src/presentation/router/routes.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_password_textfield_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_textfield_widget.dart';
import 'package:sima_app/src/utils/colors.dart';

class FormLoginWidget extends StatefulWidget {
  const FormLoginWidget({super.key});

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;
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
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Masukkan email dan kata sandi akun',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Center(
                child: Transform.translate(
                  offset: Offset(0, animation.value),
                  child: Image.asset(
                    'assets/images/login.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              );
            },
          ),
          const Text(
            'Email',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextFieldWidget(
              onChanged: (value) {
                email = value.trim();
              },
              icon: Icons.email_rounded,
              hintText: 'contoh123@sucofindo.com',
              obscureText: false,
              isReadOnly: false,
              validator: (value) {
                final emailRegex =
                    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                if (value == null || value.isEmpty) {
                  return 'Email Tidak Boleh Kosong!';
                } else if (!emailRegex.hasMatch(value)) {
                  return 'Masukkan Alamat Email Dengan Benar!';
                }
                return null;
              }),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
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
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.forgotPasswordScreen);
              },
              child: Text(
                'Lupa Password?',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButtonWidget(
            text: 'Login',
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
          ),
        ],
      ),
    );
  }
}