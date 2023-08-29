import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voting_app/app/core/interface/alerts/alert_info.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/models/pemilih.dart';
import 'package:voting_app/app/core/services/method.dart';
import 'package:voting_app/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:voting_app/app/modules/home/controllers/control_pem_controller.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/models/pemilihan.dart';

class HomeController extends GetxController with StateMixin<List<CapresModel>> {
  List<CapresModel> listCapresModel = [];
  List<CapresModel> listCapresModelPeriodeIni = [];
  final cValidate = TextEditingController();
  final cMemilih = TextEditingController();
  final formKeyValidate = GlobalKey<FormState>();
  final isLoadingMemilih = false.obs;
  final isLoadingValidate = false.obs;
  final isValidate = false.obs;
  final methodApp = MethodApp();

  final contPem = Get.find<ControlPemController>();
  final contDas = Get.find<DashboardController>();

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

  Future memilih({required String idCapres}) async {
    initLoadingMemilih();
    try {
      final capresDocRef = methodApp.capres(idCapres);
      final pemilihDocRef = methodApp.pemilih(ConstansApp.idLogin!);
      await methodApp.addPemilihan(
        data: PemilihanModel(
          capres: capresDocRef,
          pemilih: pemilihDocRef,
          tglMemilih: Timestamp.now(),
        ).toMap(),
      );
      final pemilih = contDas.pemilihModel!;
      final data = PemilihModel(
        stb: pemilih.stb!,
        nama: pemilih.nama!,
        jkl: pemilih.jkl,
        prody: pemilih.prody,
        pass: pemilih.pass,
        isMemilih: true,
        isAktif: pemilih.isAktif,
      );
      log('idLogin ${ConstansApp.idLogin}');
      await methodApp.updatePemilih(
        id: ConstansApp.idLogin!,
        data: data.toMap(),
      );

      contDas.successState(data);

      Get.back();
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
        listCapresModelPeriodeIni = listCapresModel
            .where(
              (e) => e.isPeriode == true,
            )
            .toList();
        log('${listCapresModel.length}', name: 'Capres');
        log('${listCapresModelPeriodeIni.length}', name: 'Capres periode ini');
        change(listCapresModelPeriodeIni, status: RxStatus.success());
      } else {
        log('Kosong', name: 'Capres');
        change([], status: RxStatus.empty());
      }
    });
    super.onInit();
  }
}
