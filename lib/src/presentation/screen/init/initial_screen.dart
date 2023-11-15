import 'package:flutter/material.dart';
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
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    animation = Tween(begin: -10.0, end: 10.0).animate(controller);
  }

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
              padding: const EdgeInsets.all(20.0),
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
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Selamat Datang di',
                    style: TextStyle(color: AppColor.greyColor, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Sistem Monitoring Aset',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ajukan peminjaman dan pengembalian aset di Sucofindo. Daftarkan akun dan ajukan peminjaman atau pengembalian aset. ',
                    style: TextStyle(
                      color: AppColor.greyColor,
                      fontSize: 14,
                      height: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Center(
                        child: Transform.translate(
                          offset: Offset(0, animation.value),
                          child: SizedBox(
                            width: 200,
                            child: Image.asset(
                              'assets/images/box.png',
                              fit: BoxFit.contain,
                              width: 160,
                              height: 160,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(160, 60),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person_add_alt_1_rounded,
                              color: AppColor.primaryColor,
                              size: 26,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Register',
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(160, 60),
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ), // Adjust the radius as needed
                          ),
                        ),
                        child: const Row(
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
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
