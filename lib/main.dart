import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sima_app/src/presentation/router/routes.dart';
import 'package:sima_app/src/presentation/screen/auth/splash_screen.dart';
import 'package:sima_app/src/presentation/screen/init/initial_screen.dart';
import 'package:sima_app/src/utils/colors.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SIMA Sucofindo",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
          color: AppColor.primaryColor,
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
      },
    );
  }
}
