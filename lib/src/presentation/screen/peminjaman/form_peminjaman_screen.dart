import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:sima_app/src/datasource/aset_remote_datasource.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/qrscanner_peminjaman_screen.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/widgets/date_text_form_field_widget.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/widgets/text_form_field_widget.dart';
import 'package:sima_app/src/utils/colors.dart';

class FormPeminjamanScreen extends StatefulWidget {
  final String username;
  final String token;
  final String namaAlat;
  final String tagNumber;
  final String merkAlat;
  final String typeAlat;
  final String nomorSeri;
  final String pjAlat;
  const FormPeminjamanScreen({
    super.key,
    required this.username,
    required this.namaAlat,
    required this.tagNumber,
    required this.merkAlat,
    required this.typeAlat,
    required this.nomorSeri,
    required this.pjAlat,
    required this.token,
  });

  @override
  State<FormPeminjamanScreen> createState() => _FormPeminjamanScreenState();
}

class _FormPeminjamanScreenState extends State<FormPeminjamanScreen> {
  final formKey = GlobalKey<FormState>();
  late String namaAset = '';
  late String tagNumber = '';
  late String merkAset = '';
  late String typeAset = '';
  late String noSeri = '';
  late String pjAset = '';
  late String lokasi;
  late String kondisiAset;
  late String tanggalPeminjaman = '';
  late String tujuanPeminjaman;
  final AsetRemoteDataSource asetRemoteDataSource = AsetRemoteDataSource();
  bool isLoading = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2301),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        tanggalPeminjaman = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void createPeminjaman(
      context,
      String tagNumber,
      String lokasi,
      String kondisiAset,
      String tanggalPeminjaman,
      String tujuanPeminjaman,
      String username) async {
    setState(() {
      isLoading = true;
    });

    await asetRemoteDataSource.createPeminjaman(
      context,
      tagNumber,
      lokasi,
      kondisiAset,
      tanggalPeminjaman,
      tujuanPeminjaman,
      username,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form\nPeminjaman Aset',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QRScannerPeminjamanScreen(
                    username: widget.username,
                    token: widget.token,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.qr_code_scanner,
            ),
          )
        ],
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          Opacity(
            opacity: isLoading ? 0.5 : 1.0,
            child: AbsorbPointer(
              absorbing: isLoading,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0).w,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0).w,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Data Aset',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  initialValue: widget.namaAlat,
                                  onChanged: (value) {
                                    namaAset = value.trim();
                                  },
                                  text: 'Nama Aset',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Nama Aset!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  initialValue: widget.tagNumber,
                                  onChanged: (value) {
                                    tagNumber = value.trim();
                                  },
                                  text: 'Tag Number',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Tag Number!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  initialValue: widget.merkAlat,
                                  onChanged: (value) {
                                    merkAset = value.trim();
                                  },
                                  text: 'Merek',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Merek Aset!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  initialValue: widget.typeAlat,
                                  onChanged: (value) {
                                    typeAset = value.trim();
                                  },
                                  text: 'Tipe',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Tipe Aset!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  initialValue: widget.nomorSeri,
                                  onChanged: (value) {
                                    noSeri = value.trim();
                                  },
                                  text: 'Nomor Seri',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Nomor Seri!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  initialValue: widget.pjAlat,
                                  onChanged: (value) {
                                    pjAset = value.trim();
                                  },
                                  text: 'Penanggung Jawab Alat',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Penanggung Jawab Alat!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0).w,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.r),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0).w,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Status Aset',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  onChanged: (value) {
                                    lokasi = value.trim();
                                  },
                                  text: 'Lokasi Aset',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Lokasi Alat';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  onChanged: (value) {
                                    kondisiAset = value.trim();
                                  },
                                  text: 'Kondisi Aset',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Kondisi Aset!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                DateFormTextFieldWidget(
                                  onTap: () => selectDate(context),
                                  isReadOnly: true,
                                  controller: TextEditingController(
                                    text: tanggalPeminjaman,
                                  ),
                                  onChanged: (value) {
                                    tanggalPeminjaman = value.trim();
                                  },
                                  text: 'Tanggal Peminjaman',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Tanggal Peminjaman!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                  onChanged: (value) {
                                    tujuanPeminjaman = value.trim();
                                  },
                                  text: 'Tujuan Peminjaman',
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Isi Tujuan Peminjaman!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0).w,
                        child: CustomButtonWidget(
                          text: 'Submit',
                          textColor: AppColor.whiteColor,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              createPeminjaman(
                                  context,
                                  widget.tagNumber,
                                  lokasi,
                                  kondisiAset,
                                  tanggalPeminjaman,
                                  tujuanPeminjaman,
                                  widget.username);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
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
      ),
    );
  }
}
