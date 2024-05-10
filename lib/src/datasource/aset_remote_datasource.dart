import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:sima_app/src/model/peminjaman_response_model.dart';
import 'package:sima_app/src/model/pengembalian_response_model.dart';
import 'package:sima_app/src/presentation/screen/peminjaman/form_peminjaman_screen.dart';
import 'package:sima_app/src/presentation/screen/pengembalian/form_pengembalian_screen.dart';
import 'package:sima_app/src/utils/constant.dart';
import 'package:sima_app/src/widgets/toast_widget.dart';

class AsetRemoteDataSource {
  Future<void> peminjamanData(BuildContext context, String tagNum,
      String username, String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}${Constant.tagNumberPath(tagNum)}'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
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
                  token: token),
            ),
          );
        });

        showToast("Data loaded successfully", true);
      } else {
        showToast("Failed to load data", false);
      }
    } catch (e) {
      showToast("Error: $e", false);
    }
  }

  Future<void> pengembalianData(BuildContext context, String tagNum,
      String username, String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Constant.baseUrl}${Constant.tagNumberPath(tagNum)}'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
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
                token: token,
              ),
            ),
          );
        });

        showToast("Data loaded successfully", true);
      } else {
        showToast("Failed to load data", false);
      }
    } catch (e) {
      showToast("Error: $e", false);
    }
  }

  Future<void> createPeminjaman(
    BuildContext context,
    String tagNumber,
    String lokasi,
    String kondisiAset,
    String tanggalPeminjaman,
    String tujuanPeminjaman,
    String hari,
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
          'tujuan_peminjaman': tujuanPeminjaman,
          'waktu_peminjaman': hari,
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
    BuildContext context,
    String tagNumber,
    String lokasi,
    String kondisiAset,
    String tanggalPengembalian,
    String username,
    File? foto,
  ) async {
    var uri = Uri.parse('${Constant.baseUrl}${Constant.pengembalianPath}');
    var request = http.MultipartRequest('POST', uri);

    request.fields['lokasi'] = lokasi;
    request.fields['kondisi_aset'] = kondisiAset;
    request.fields['tagNumber'] = tagNumber;
    request.fields['tanggal_pengembalian'] = tanggalPengembalian;
    request.fields['username'] = username;
    request.files.add(
      await http.MultipartFile.fromPath(
        'foto',
        foto!.path,
        contentType: MediaType('image', 'png'),
      ),
    );

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 201) {
        showToast("Pengembalian berhasil", true);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else if (response.statusCode == 400) {
        showToast("Peminjaman aset belum disetujui", false);
      } else if (response.statusCode == 404) {
        showToast("Aset Tidak Ditemukan", false);
      } else {
        showToast("Pengembalian Gagal", false);
      }
    } catch (e) {
      showToast("Error: $e", false);
    }
  }

  Future<PeminjamanResponseModel> loadPeminjamanData(
      String userId, String token) async {
    try {
      final url = '${Constant.baseUrl}${Constant.peminjamanUserPath(userId)}';
      final result = await Dio().get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final peminjamanResponse = PeminjamanResponseModel.fromMap(result.data);
      log('Response Body: $result');
      return peminjamanResponse;
    } catch (e, stackTrace) {
      log(
        e.toString(),
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PengembalianResponseModel> loadPengembalianData(
      String userId, String token) async {
    try {
      final url = '${Constant.baseUrl}${Constant.pengembalianUserPath(userId)}';
      final result = await Dio().get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final pengembalianResponse =
          PengembalianResponseModel.fromMap(result.data);
      log('Response Body: $result');
      return pengembalianResponse;
    } catch (e, stackTrace) {
      log(
        e.toString(),
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
