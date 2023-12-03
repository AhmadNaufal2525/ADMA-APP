import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/form_aset_button_widget.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/form_peminjaman_screen.dart';
import 'package:sima_app/src/presentation/screen/pengembalian/form_pengembalian_screen.dart';
import 'package:sima_app/src/utils/colors.dart';

class PengajuanFormWidget extends StatelessWidget {
  final String username;
  final String token;
  const PengajuanFormWidget({super.key, required this.username, required this.token});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 180,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/images/circle.png',
                width: 240.w,
                height: 240.h,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0).w,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Form Aset',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    FormAsetButtonWidget(
                      icon: 'assets/icon/pinjam.png',
                      backgroundColor: AppColor.primaryColor,
                      label: 'Peminjaman Aset',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormPeminjamanScreen(
                              username: username,
                              tagNumber: '',
                              namaAlat: '',
                              merkAlat: '',
                              typeAlat: '',
                              nomorSeri: '',
                              pjAlat: '', token: token,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 18.w,
                    ),
                    FormAsetButtonWidget(
                      icon: 'assets/icon/kembali.png',
                      backgroundColor: const Color(0xffFF9839),
                      label: 'Pengembalian Aset',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormPengembalianScreen(
                              username: username,
                              tagNumber: '',
                              namaAlat: '',
                              pjAlat: '', token: token,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
