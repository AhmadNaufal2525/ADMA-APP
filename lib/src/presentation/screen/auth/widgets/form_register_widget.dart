import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_password_textfield_widget.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_textfield_widget.dart';

class FormRegisterWidget extends StatefulWidget {
  const FormRegisterWidget({super.key});

  @override
  State<FormRegisterWidget> createState() => _FormRegisterWidgetState();
}

class _FormRegisterWidgetState extends State<FormRegisterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final formKey = GlobalKey<FormState>();
  late String username;
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Silahkan isi kelengkapan akun',
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
                      'assets/images/register.png',
                      width: 160,
                      height: 160,
                    ),
                  ),
                );
              },
            ),
            const Text(
              'Username',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFieldWidget(
              onChanged: (value) {
                username = value.trim();
              },
              icon: Icons.person_2,
              hintText: 'Username',
              obscureText: false,
              isReadOnly: false,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username Tidak Boleh Kosong!';
                } else if (value.length < 8) {
                  return 'Username harus terdiri dari 8 karakter!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFieldWidget(
              onChanged: (value) {
                email = value.trim();
              },
              icon: Icons.email_rounded,
              hintText: 'Email',
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
              },
            ),
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
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text:
                    'Dengan mendaftarkan akun, anda telah menyetujui untuk menerima ',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: GoogleFonts.openSans().fontFamily,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: 'Privasi dan Kebijakan Sucofindo',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButtonWidget(
              text: 'Register',
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
