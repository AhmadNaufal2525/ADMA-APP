import 'dart:convert';

PeminjamanResponseModel peminjamanResponseModelFromMap(String str) => PeminjamanResponseModel.fromMap(json.decode(str));

String peminjamanResponseModelToMap(PeminjamanResponseModel data) => json.encode(data.toMap());

class PeminjamanResponseModel {
    String? message;
    List<Peminjaman>? peminjaman;

    PeminjamanResponseModel({
        this.message,
        this.peminjaman,
    });

    factory PeminjamanResponseModel.fromMap(Map<String, dynamic> json) => PeminjamanResponseModel(
        message: json["message"],
        peminjaman: json["peminjaman"] == null ? [] : List<Peminjaman>.from(json["peminjaman"]!.map((x) => Peminjaman.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "peminjaman": peminjaman == null ? [] : List<dynamic>.from(peminjaman!.map((x) => x.toMap())),
    };
}

class Peminjaman {
    String? id;
    String? idUser;
    String? status;
    IdAset? idAset;
    String? lokasi;
    String? kondisiAset;
    String? tanggalPeminjaman;
    String? tujuanPeminjaman;
    String? jenis;

    Peminjaman({
        this.id,
        this.idUser,
        this.status,
        this.idAset,
        this.lokasi,
        this.kondisiAset,
        this.tanggalPeminjaman,
        this.tujuanPeminjaman,
        this.jenis,
    });

    factory Peminjaman.fromMap(Map<String, dynamic> json) => Peminjaman(
        id: json["_id"],
        idUser: json["id_user"],
        status: json["status"],
        idAset: json["id_aset"] == null ? null : IdAset.fromMap(json["id_aset"]),
        lokasi: json["lokasi"],
        kondisiAset: json["kondisi_aset"],
        tanggalPeminjaman: json["tanggal_peminjaman"],
        tujuanPeminjaman: json["tujuan_peminjaman"],
        jenis: json["jenis"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "id_user": idUser,
        "status": status,
        "id_aset": idAset?.toMap(),
        "lokasi": lokasi,
        "kondisi_aset": kondisiAset,
        "tanggal_peminjaman": tanggalPeminjaman,
        "tujuan_peminjaman": tujuanPeminjaman,
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
