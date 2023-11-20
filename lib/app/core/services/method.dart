import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/models/pemilih.dart';
import 'package:voting_app/app/core/services/api.dart';

import '../constans/constans_app.dart';
import '../models/pemilihan.dart';

class MethodApp {
  Future addPemilihan({
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihanCollection)
        .add(data);
  }

  Future addPemilih({
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .add(data);
  }

  Future addCapres({
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.capresCollection)
        .add(data);
  }

  Future updatePemilih({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .doc(id)
        .update(data);
  }

  DocumentReference<PemilihModel> pemilih(String idPemilih) {
    return ConstansApp.firestore
        .collection(ConstansApp.pemilihCollection)
        .doc(idPemilih)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PemilihModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  DocumentReference<PemilihanModel> pemilihan(String idPemilihan) {
    return ConstansApp.firestore
        .collection(ConstansApp.pemilihanCollection)
        .doc(idPemilihan)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              PemilihanModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  DocumentReference<CapresModel> capres(String idCapres) {
    return ConstansApp.firestore
        .collection(ConstansApp.capresCollection)
        .doc(idCapres)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              CapresModel.fromDocumentSnapshot(snapshot),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  Future<MhsModel?> getUser(String stb, String pass) async {
    final mhsProvider = MhsProvider();
    final response = await mhsProvider.getUser(
      int.parse(stb),
      pass,
    );
    if (response.statusCode == 200) {
      log("ada data");
      final mhs = response.body['data'][0];
      final dataMhs = MhsModel(
        stb: mhs['stb'],
        nmmhs: mhs['nmmhs'],
        alm: mhs['alm'],
        email: mhs['email'],
        nohp: mhs['nohp'],
      );
      return dataMhs;
    } else {
      return null;
    }
  }
}
