import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/model/peminjaman_response_model.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/card_pengajuan_widget.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/empty_data_widget.dart';

class PengajuanPeminjamanWidget extends StatelessWidget {
  final List<Peminjaman> pengajuanData;
  final int selectedTabIndex;

  const PengajuanPeminjamanWidget({
    Key? key,
    required this.pengajuanData,
    required this.selectedTabIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Peminjaman> filteredPengajuan = pengajuanData
        .where(
          (pengajuan) =>
              pengajuan.status == 'Rejected' ||
              pengajuan.status == 'Approved' ||
              pengajuan.status == 'Pending',
        )
        .toList();

    return SizedBox(
      height: 330.h,
      child: filteredPengajuan.isEmpty
          ? const Center(
              child: EmptyDataWidget(),
            )
          : ListView.separated(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 16),
              itemCount: filteredPengajuan.length,
              itemBuilder: (BuildContext context, int index) {
                final pengajuan = filteredPengajuan[index];
                return CardPengajuanWidget(
                  date: pengajuan.tanggalPeminjaman ?? '',
                  status: pengajuan.status ?? '',
                  text: pengajuan.idAset!.namaAlat ?? '',
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 16.h,
              ),
            ),
    );
  }
}
