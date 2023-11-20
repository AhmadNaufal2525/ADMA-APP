import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sima_app/src/presentation/router/routes.dart';
import 'package:sima_app/src/presentation/screen/auth/forgot_password_screen.dart';
import 'package:sima_app/src/presentation/screen/auth/login_screen.dart';
import 'package:sima_app/src/presentation/screen/auth/register_screen.dart';
import 'package:sima_app/src/presentation/screen/auth/splash_screen.dart';
import 'package:sima_app/src/presentation/screen/init/initial_screen.dart';
import 'package:sima_app/src/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SIMA",
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: AppColor.primaryColor,
            titleTextStyle: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            centerTitle: true,
            actionsIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            toolbarHeight: 80,
            elevation: 1,
          ),
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        initialRoute: '/',
        routes: {
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.initScreen: (context) => const InitialScreen(),
          Routes.loginScreen: (context) => const LoginScreen(),
          Routes.registerScreen:(context) => const RegisterScreen(),
          Routes.forgotPasswordScreen:(context) => const ForgotPasswordScreen(),
        },
      ),
      designSize: Size(width, height),
    );
  }
}
