import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:sima_app/src/datasource/aset_remote_datasource.dart';
import 'package:sima_app/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/widgets/date_text_form_field_widget.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/widgets/text_form_field_widget.dart';
import 'package:sima_app/src/presentation/screen/pengembalian/qrscanner_pengembalian_screen.dart';
import 'package:sima_app/src/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class FormPengembalianScreen extends StatefulWidget {
  final String username;
  final String token;
  final String namaAlat;
  final String tagNumber;
  final String pjAlat;
  const FormPengembalianScreen({
    super.key,
    required this.username,
    required this.namaAlat,
    required this.tagNumber,
    required this.pjAlat,
    required this.token,
  });

  @override
  State<FormPengembalianScreen> createState() => _FormPengembalianScreenState();
}

class _FormPengembalianScreenState extends State<FormPengembalianScreen> {
  final formKey = GlobalKey<FormState>();
  late String namaAset = '';
  late String tagNumber = '';
  late String pjAset = '';
  late String lokasi;
  late String kondisiAset;
  late String tanggalPengembalian = '';
  File? foto;
  final AsetRemoteDataSource asetRemoteDataSource = AsetRemoteDataSource();
  bool isLoading = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        tanggalPengembalian = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> getImage() async {
    final XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 25);
    if (image != null) {
      final File file = File(image.path);
      String newPath =
          file.path.replaceAll(RegExp(r'\.(?:jpg|jpeg|png|gif)'), '.png');
      File newFile = await file.rename(newPath);
      setState(() {
        foto = newFile;
      });
    }
  }

  void imageAlert() {
    Future.delayed(Duration.zero, () {
      Dialogs.materialDialog(
        msg: 'Foto Aset Tidak Ditemukan',
        title: 'Silahkan Foto Terlebih dahulu Aset yang akan dikembalikan',
        color: Colors.white,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            text: 'OK',
            iconData: Icons.check_circle,
            color: Colors.green,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ],
      );
    });
  }

  void createPengembalian(
    context,
    String tagNumber,
    String lokasi,
    String kondisiAset,
    String tanggalPengembalian,
    String username,
    File? foto,
  ) async {
    setState(() {
      isLoading = true;
    });
    await asetRemoteDataSource.createPengembalian(
      context,
      tagNumber,
      lokasi,
      kondisiAset,
      tanggalPengembalian,
      username,
      foto,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Form\nPengembalian Aset',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => QRScannerPengembalianScreen(
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
                                    }),
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
                                    }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                    initialValue: widget.pjAlat,
                                    onChanged: (value) {
                                      pjAset = value.trim();
                                    },
                                    text: 'Penanggung Jawab Aset',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Isi Penanggung Jawab Alat!';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                                    }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                TextFormFieldWidget(
                                    onChanged: (value) {
                                      kondisiAset = value.trim();
                                    },
                                    text: 'Kondisi Aset Saat Dikembalikan',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Isi Kondisi Aset!';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 20.h,
                                ),
                                DateFormTextFieldWidget(
                                    onTap: () => selectDate(context),
                                    isReadOnly: true,
                                    controller: TextEditingController(
                                        text: tanggalPengembalian),
                                    onChanged: (value) {
                                      tanggalPengembalian = value.trim();
                                    },
                                    text: 'Tanggal Pengembalian',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Isi Tanggal Pengembalian!';
                                      }
                                      return null;
                                    }),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                                    'Foto Aset',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    height: 400.h,
                                    decoration: BoxDecoration(
                                      color: AppColor.whiteColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
                                      ),
                                    ),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          foto == null
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      size: 30.sp,
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    const Text(
                                                        'Ambil Foto Aset')
                                                  ],
                                                )
                                              : Image.file(
                                                  File(foto!.path).absolute,
                                                  height: 360.h,
                                                ),
                                          if (foto != null)
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    foto = null;
                                                  });
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                          textColor: Colors.white,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              createPengembalian(
                                context,
                                widget.tagNumber,
                                lokasi,
                                kondisiAset,
                                tanggalPengembalian,
                                widget.username,
                                foto,
                              );
                            } else if (foto == null) {
                              imageAlert();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
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
