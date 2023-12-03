import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sima_app/src/model/pengembalian_response_model.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/card_pengajuan_widget.dart';
import 'package:sima_app/src/presentation/screen/home/widgets/empty_data_widget.dart';

class PengajuanPengembalianWidget extends StatelessWidget {
  final List<Pengembalian> pengajuanData;
  final int selectedTabIndex;
  const PengajuanPengembalianWidget(
      {super.key, required this.pengajuanData, required this.selectedTabIndex});

  @override
  Widget build(BuildContext context) {
    List<Pengembalian> filteredPengajuan = pengajuanData
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
                  date: pengajuan.tanggalPengembalian ?? '',
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
