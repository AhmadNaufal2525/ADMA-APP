import 'package:flutter/material.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/form_forgot_password_widget.dart';
import 'package:sima_app/src/utils/colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Image.asset(
                      'assets/images/logo.png',
                      color: AppColor.primaryColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const FormForgotPasswordWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}