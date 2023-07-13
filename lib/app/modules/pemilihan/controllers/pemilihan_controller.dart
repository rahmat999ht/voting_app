import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_app/app/core/models/pemilihan.dart';
import 'package:voting_app/app/modules/pemilihan/controllers/pemilih_controller.dart';

import '../../../core/constans/constans_app.dart';
import '../../home/controllers/home_controller.dart';

class PemilihanController extends GetxController
    with StateMixin<List<PemilihanModel>> {
  List<PemilihanModel> listPemilihanModel = [];
  // List<PemilihanModel> listPemilihanModel = [];
  Stream<QuerySnapshot<Map<String, dynamic>>> get getListCapres =>
      ConstansApp.firestore
          .collection(ConstansApp.pemilihanCollection)
          .snapshots();

  final listColors = [
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.grey,
  ];

  final controllerHome = Get.find<HomeController>();
  final controllerPemilih = Get.find<PemilihController>();

  @override
  void onInit() {
    getListCapres.listen((event) {
      if (event.size != 0) {
        listPemilihanModel = List.generate(
          event.docs.length,
          (index) => PemilihanModel.fromDocumentSnapshot(event.docs[index]),
        ).toList();
        log('${listPemilihanModel.length}', name: 'Pemilihan');
        change(listPemilihanModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Pemilihan');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
