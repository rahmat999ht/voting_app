import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:voting_app/app/core/models/pemilih.dart';

import '../../../core/constans/constans_app.dart';

class PemilihController extends GetxController
    with StateMixin<List<PemilihModel>> {
  final touchedIndex = 0.obs;
  List<PemilihModel> listPemilihModel = [];
  List<PemilihModel> listBelumMemilih = [];
  Stream<QuerySnapshot<Map<String, dynamic>>> get getListCapres =>
      ConstansApp.firestore
          .collection(ConstansApp.pemilihCollection)
          .snapshots();

  @override
  void onInit() {
    getListCapres.listen((event) {
      if (event.size != 0) {
        listPemilihModel = List.generate(
          event.docs.length,
          (index) => PemilihModel.fromDocumentSnapshot(event.docs[index]),
        ).toList();
        listBelumMemilih = listPemilihModel
            .where((e) => e.isMemilih == false && e.isAktif == true)
            .toList();
        log('${listPemilihModel.length}', name: 'Pemilih');
        change(listPemilihModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Pemilih');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
