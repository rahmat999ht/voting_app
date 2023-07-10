// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'image_hash.dart';

class CapresModel {
  String? id;
  String? stb;
  String? noUrut;
  ImageHash? foto;
  String? nama;
  String? jkl;
  String? visi;
  String? misi;
  CapresModel({
    this.id,
    this.stb,
    this.noUrut,
    this.foto,
    this.nama,
    this.jkl,
    this.visi,
    this.misi,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'stb': stb,
      'noUrut': noUrut,
      'foto': foto?.toMap(),
      'nama': nama,
      'jkl': jkl,
      'visi': visi,
      'misi': misi,
    };
  }

  factory CapresModel.fromMapById(String id, Map<String, dynamic> map) {
    return CapresModel(
      id: id,
      stb: map['stb'] != null ? map['stb'] as String : null,
      noUrut: map['noUrut'] != null ? map['noUrut'] as String : null,
      foto: map['foto'] != null
          ? ImageHash.fromMap(map['foto'] as Map<String, dynamic>)
          : null,
      nama: map['nama'] != null ? map['nama'] as String : null,
      jkl: map['jkl'] != null ? map['jkl'] as String : null,
      visi: map['visi'] != null ? map['visi'] as String : null,
      misi: map['misi'] != null ? map['misi'] as String : null,
    );
  }

  factory CapresModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String, dynamic>> data,
  ) =>
      CapresModel.fromMapById(
        data.id,
        data.data() as Map<String, dynamic>,
      );
}
