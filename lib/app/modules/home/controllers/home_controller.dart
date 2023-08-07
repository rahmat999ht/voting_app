import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_app/app/core/interface/alerts/alert_info.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/services/method.dart';

import '../../../core/constans/constans_app.dart';

class HomeController extends GetxController with StateMixin<List<CapresModel>> {
  List<CapresModel> listCapresModel = [];
  final cValidate = TextEditingController();
  final cMemilih = TextEditingController();
  final formKeyValidate = GlobalKey<FormState>();
  final isLoadingMemilih = false.obs;
  final isLoadingValidate = false.obs;
  final isValidate = false.obs;
  final methodApp = MethodApp();

  void initLoadingMemilih() {
    isLoadingMemilih.value = !isLoadingMemilih.value;
  }

  void initLoadingValidate() {
    isLoadingValidate.value = !isLoadingValidate.value;
  }

  void initValidate() {
    isValidate.value = true;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get getListCapres =>
      ConstansApp.firestore
          .collection(ConstansApp.capresCollection)
          .snapshots();

  Future memilih() async {
    initLoadingMemilih();
    try {
      if (isValidate.isTrue) {
        Future.delayed(
          const Duration(seconds: 5),
        );
        // final capresDocRef = methodApp.capres(ConstansApp.idLogin!);
        // final pemilihDocRef = methodApp.capres(ConstansApp.idLogin!);
        // await methodApp.addPemilihan(
        //   PemilihanModel(
        //     capres: capresDocRef,
        //     pemilih: pemilihDocRef,
        //     tglMemilih: Timestamp.now(),
        //   ).toMap(),
        // );
        Get.back();
      } else {
        Get.back();
        alertInfo(
          'Info',
          'Anda belum melalukan verifikasi',
        );
      }
    } catch (e) {
      log('pesan error $e');
    }
    initLoadingMemilih();
  }

  void validate() {
    initLoadingValidate();
    try {
      if (formKeyValidate.currentState!.validate()) {
        if (cValidate.text == 'benar') {
          initValidate();
          // kode di dalam sini menerapkan algoritma Nakula Sadewa
        } else {
          alertInfo(
            'Info',
            'Kode yang anda input salah',
          );
        }
      }
    } catch (e) {
      log('pesan error $e');
    }
    initLoadingValidate();
  }

  @override
  void onInit() {
    getListCapres.listen((event) {
      if (event.size != 0) {
        listCapresModel = List.generate(
          event.docs.length,
          (index) => CapresModel.fromDocumentSnapshot(event.docs[index]),
        ).toList();
        listCapresModel.sort(
          (a, b) => a.noUrut!.compareTo(b.noUrut!),
        );
        log('${listCapresModel.length}', name: 'Capres');
        change(listCapresModel, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Capres');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
