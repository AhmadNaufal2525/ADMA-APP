import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/datasource/auth_remote_datasource.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/card_pengajuan_widget.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/form_aset_button_widget.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/form_peminjaman_screen.dart';
import 'package:sima_app/src/presentation/screen/pengembalian/form_pengembalian_screen.dart';
import 'package:sima_app/src/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:sima_app/src/utils/constant.dart';
import 'package:sima_app/src/widgets/toast_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  final String username;
  final String userId;
  final String token;

  const HomeScreen(
      {super.key,
      required this.username,
      required this.userId,
      required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthRemoteDataSource authDataSource = AuthRemoteDataSource();
  List<dynamic> tabData = [];
  List<dynamic> filteredTabData = [];
  int selectedTabIndex = 0;
  @override
  void initState() {
    super.initState();
    loadPeminjamanData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> refreshData() async {
    await loadPeminjamanData();
  }

  void filterTabData() {
    if (selectedTabIndex == 0) {
      setState(() {
        filteredTabData = tabData
            .where((peminjaman) => peminjaman['jenis'] == 'Peminjaman')
            .toList();
      });
    } else {
      setState(() {
        filteredTabData = tabData
            .where((peminjaman) => peminjaman['jenis'] == 'Pengembalian')
            .toList();
      });
    }
  }

  Future<void> loadPeminjamanData() async {
    final response = await http.get(
      Uri.parse('${Constant.baseUrl}${Constant.peminjamanUserPath(widget.userId)}'),
    );

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> peminjamanList = responseData['peminjaman'];

        setState(() {
          tabData = peminjamanList;
          filterTabData();
        });
      }
    } catch (error) {
      showToast("Failed to load peminjaman data.", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(15.r),
                      bottomStart: Radius.circular(15.r),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 14.h,
                                ),
                                Text(
                                  'Halo, ${widget.username} 👋',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  DateFormat("dd MMM, yyyy")
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  color: Colors.white,
                                  width: 100.w,
                                  height: 100.h,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 14),
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
                                              builder: (context) =>
                                                  FormPeminjamanScreen(
                                                username: widget.username,
                                                tagNumber: '',
                                                namaAlat: '',
                                                merkAlat: '',
                                                typeAlat: '',
                                                nomorSeri: '',
                                                pjAlat: '',
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
                                              builder: (context) =>
                                                  FormPengembalianScreen(
                                                username: widget.username,
                                                tagNumber: '',
                                                namaAlat: '',
                                                pjAlat: '',
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
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Tracking Pengajuan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Lihat progress pengajuan barang disini',
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            ButtonsTabBar(
                              radius: 30.r,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 46),
                              backgroundColor: AppColor.primaryColor,
                              unselectedBackgroundColor: const Color(0xffFF9839),
                              unselectedLabelStyle:
                                  const TextStyle(color: Colors.white),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              tabs: const [
                                Tab(
                                  text: "Peminjaman",
                                ),
                                Tab(
                                  text: "Pengembalian",
                                ),
                              ],
                              onTap: (index) {
                                setState(() {
                                  selectedTabIndex = index;
                                  filterTabData();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: filteredTabData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final peminjaman = filteredTabData[index];
                    return CardPengajuanWidget(
                      date: peminjaman['tanggal_peminjaman'],
                      status: peminjaman['status'],
                      text: peminjaman['id_aset']['nama_alat'],
                    );
                  },
                ),
              ),
            ),
             SizedBox(
                height: 20.h,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: AppColor.primaryColor,
        onPressed: () {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Confirm Logout'),
                content: const Text('Are you sure you want to log out?'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      authDataSource.signOut(context, widget.token);
                    },
                    isDestructiveAction: true,
                    child: const Text('Logout'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.logout_rounded),
      ),
    );
  }
}
