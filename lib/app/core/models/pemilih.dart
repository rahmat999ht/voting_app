import 'package:cloud_firestore/cloud_firestore.dart';

class PemilihModel {
  String? id;
  String? stb;
  String? nama;
  String? jkl;
  String? alamat;
  String? pass;
  bool? isMemilih;
  bool? isAktif;
  PemilihModel({
    this.id,
    this.stb,
    this.nama,
    this.jkl,
    this.alamat,
    this.pass,
    this.isMemilih,
    this.isAktif,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stb': stb,
      'nama': nama,
      'jkl': jkl,
      'alamat': alamat,
      'pass': pass,
      'isMemilih': isMemilih,
      'isAktif': isAktif,
    };
  }

  factory PemilihModel.fromMapById(String id, Map<String, dynamic> map) {
    return PemilihModel(
      id: id,
      stb: map['stb'] != null ? map['stb'] as String : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      jkl: map['jkl'] != null ? map['jkl'] as String : null,
      alamat: map['alamat'] != null ? map['alamat'] as String : null,
      pass: map['pass'] != null ? map['pass'] as String : null,
      isMemilih: map['isMemilih'] != null ? map['isMemilih'] as bool : null,
      isAktif: map['isAktif'] != null ? map['isAktif'] as bool : null,
    );
  }

  factory PemilihModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      PemilihModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
