import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sima_app/src/presentation/screen/peminjaman/form_peminjaman_screen.dart';
import 'package:sima_app/src/presentation/screen/pengembalian/form_pengembalian_screen.dart';
import 'package:sima_app/src/utils/constant.dart';
import 'package:sima_app/src/widgets/toast_widget.dart';

class AsetRemoteDataSource {
  Future<void> peminjamanData(
      BuildContext context, String tagNum, String username) async {
    final response = await http.get(
      Uri.parse('${Constant.baseUrl}${Constant.tagNumberPath(tagNum)}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String namaAlat = responseData['data']['nama_alat'];
      final String tagNumber = responseData['data']['tag_number'];
      final String merkAlat = responseData['data']['merek'];
      final String tipe = responseData['data']['tipe'];
      final String nomorSeri = responseData['data']['nomor_seri'];
      final String pjAlat = responseData['data']['penanggung_jawab'];

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FormPeminjamanScreen(
              namaAlat: namaAlat,
              tagNumber: tagNumber,
              merkAlat: merkAlat,
              typeAlat: tipe,
              nomorSeri: nomorSeri,
              pjAlat: pjAlat,
              username: username,
            ),
          ),
        );
      });

      showToast("Data loaded successfully", true);
    } else {
      showToast("Failed to load data", false);
    }
  }

  Future<void> pengembalianData(
      BuildContext context, String tagNum, String username) async {
    final response = await http.get(
      Uri.parse('${Constant.baseUrl}${Constant.tagNumberPath(tagNum)}'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String namaAlat = responseData['data']['nama_alat'];
      final String tagNumber = responseData['data']['tag_number'];
      final String pjAlat = responseData['data']['penanggung_jawab'];

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FormPengembalianScreen(
              namaAlat: namaAlat,
              tagNumber: tagNumber,
              pjAlat: pjAlat,
              username: username,
            ),
          ),
        );
      });

      showToast("Data loaded successfully", true);
    } else {
      showToast("Failed to load data", false);
    }
  }

  Future<void> createPeminjaman(
    BuildContext context,
    String tagNumber,
    String lokasi,
    String kondisiAset,
    String tanggalPeminjaman,
    String tujuanPeminjaman,
    String username,
  ) async {
    final response = await http.post(
      Uri.parse('${Constant.baseUrl}${Constant.peminjamanPath}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'tagNumber': tagNumber,
          'username': username,
          'lokasi': lokasi,
          'kondisi_aset': kondisiAset,
          'tanggal_peminjaman': tanggalPeminjaman,
          'tujuan_peminjaman': tujuanPeminjaman
        },
      ),
    );

    if (response.statusCode == 201) {
      showToast("Peminjaman berhasil", true);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } else if (response.statusCode == 400) {
      showToast("Aset Sedang Dipinjam", false);
    } else if (response.statusCode == 404) {
      showToast("User Tidak Ditemukan", false);
    } else {
      showToast("Peminjaman Gagal", false);
    }
   
  }

  Future<void> createPengembalian(
    String tagNumber,
    String lokasi,
    String kondisiAset,
    String tanggalPeminjaman,
    String username,
    String image,
  ) async {
    final response = await http.post(
      Uri.parse('${Constant.baseUrl}${Constant.pengembalianPath}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(
        <String, String>{
          'tagNumber': tagNumber,
          'username': username,
          'lokasi': lokasi,
          'kondisi_aset': kondisiAset,
          'tanggal_peminjaman': tanggalPeminjaman,
          'image_url': image
        },
      ),
    );

    if (response.statusCode == 201) {
      showToast("Pengembalian berhasil", true);
      Future.delayed(const Duration(seconds: 1), () {});
    } else if (response.statusCode == 400) {
      showToast("Aset Sedang Dipinjam", false);
    } else if (response.statusCode == 404) {
      showToast("Aset Tidak Ditemukan", false);
    } else {
      showToast("Pengembalian Gagal", false);
    }
  }
}
