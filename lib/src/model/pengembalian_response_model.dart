// To parse this JSON data, do
//
//     final pengembalianResponseModel = pengembalianResponseModelFromMap(jsonString);

import 'dart:convert';

PengembalianResponseModel pengembalianResponseModelFromMap(String str) => PengembalianResponseModel.fromMap(json.decode(str));

String pengembalianResponseModelToMap(PengembalianResponseModel data) => json.encode(data.toMap());

class PengembalianResponseModel {
    String? message;
    List<Pengembalian>? pengembalian;

    PengembalianResponseModel({
        this.message,
        this.pengembalian,
    });

    factory PengembalianResponseModel.fromMap(Map<String, dynamic> json) => PengembalianResponseModel(
        message: json["message"],
        pengembalian: json["pengembalian"] == null ? [] : List<Pengembalian>.from(json["pengembalian"]!.map((x) => Pengembalian.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "pengembalian": pengembalian == null ? [] : List<dynamic>.from(pengembalian!.map((x) => x.toMap())),
    };
}

class Pengembalian {
    String? id;
    String? idUser;
    IdAset? idAset;
    String? lokasi;
    String? kondisiAset;
    String? tanggalPengembalian;
    String? foto;
    String? status;
    String? jenis;

    Pengembalian({
        this.id,
        this.idUser,
        this.idAset,
        this.lokasi,
        this.kondisiAset,
        this.tanggalPengembalian,
        this.foto,
        this.status,
        this.jenis,
    });

    factory Pengembalian.fromMap(Map<String, dynamic> json) => Pengembalian(
        id: json["_id"],
        idUser: json["id_user"],
        idAset: json["id_aset"] == null ? null : IdAset.fromMap(json["id_aset"]),
        lokasi: json["lokasi"],
        kondisiAset: json["kondisi_aset"],
        tanggalPengembalian: json["tanggal_pengembalian"],
        foto: json["foto"],
        status: json["status"],
        jenis: json["jenis"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "id_user": idUser,
        "id_aset": idAset?.toMap(),
        "lokasi": lokasi,
        "kondisi_aset": kondisiAset,
        "tanggal_pengembalian": tanggalPengembalian,
        "foto": foto,
        "status": status,
        "jenis": jenis,
    };
}

class IdAset {
    String? id;
    String? namaAlat;
    String? tagNumber;
    String? merek;
    String? tipe;
    String? nomorSeri;
    String? penanggungJawab;
    bool? isBorrowed;
    String? lokasiAset;

    IdAset({
        this.id,
        this.namaAlat,
        this.tagNumber,
        this.merek,
        this.tipe,
        this.nomorSeri,
        this.penanggungJawab,
        this.isBorrowed,
        this.lokasiAset,
    });

    factory IdAset.fromMap(Map<String, dynamic> json) => IdAset(
        id: json["_id"],
        namaAlat: json["nama_alat"],
        tagNumber: json["tag_number"],
        merek: json["merek"],
        tipe: json["tipe"],
        nomorSeri: json["nomor_seri"],
        penanggungJawab: json["penanggung_jawab"],
        isBorrowed: json["is_borrowed"],
        lokasiAset: json["lokasi_aset"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "nama_alat": namaAlat,
        "tag_number": tagNumber,
        "merek": merek,
        "tipe": tipe,
        "nomor_seri": nomorSeri,
        "penanggung_jawab": penanggungJawab,
        "is_borrowed": isBorrowed,
        "lokasi_aset": lokasiAset,
    };
}
