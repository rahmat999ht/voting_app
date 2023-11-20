import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/app/core/interface/alerts/alert_info.dart';
import 'package:voting_app/app/routes/app_pages.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_actions.dart';
import '../../../core/models/pemilih.dart';
import '../../../core/services/api.dart';
import '../../../core/services/method.dart';
import '../components/alert_value_form.dart';

class LoginController extends GetxController {
  final methodApp = MethodApp();

  final formKey = GlobalKey<FormState>();
  final stbC = TextEditingController();
  final passC = TextEditingController();
  final sessionLoginC = TextEditingController();
  final isLoading = false.obs;
  final isObscure = true.obs;

  final userProvider = MhsProvider();

  // final dC = Get.find<DashboardController>();

  void initLoading() {
    isLoading.value = !isLoading.value;
  }

  void initObscure() {
    isObscure.value = !isObscure.value;
  }

  final listSession = [
    'Mahasiswa',
    'Capres Bem',
  ];

  Future alertStatus() async {
    await alertValueForm(
      title: "Session Login",
      listValue: listSession,
      textC: sessionLoginC,
    );
  }

  Future login() async {
    initLoading();
    try {
      if (formKey.currentState!.validate()) {
        if (sessionLoginC.text == 'Mahasiswa') {
          final pemilih = ConstansApp.firestore.collection(
            ConstansApp.pemilihCollection,
          );
          await iniData(collection: pemilih, sesiLogin: 'pemilih');
        } else {
          final capres = ConstansApp.firestore.collection(
            ConstansApp.capresCollection,
          );
          await iniData(collection: capres, sesiLogin: 'capres');
        }
      }
    } catch (e) {
      alertInfo('info', 'pesan error : $e');
    }
    initLoading();
  }

  Future iniData({
    required CollectionReference<Map<String, dynamic>> collection,
    required String sesiLogin,
  }) async {
    final response = await userProvider.getUser(
      int.parse(stbC.text),
      passC.text,
    );
    log(response.toString());
    if (response.statusCode == 200) {
      final data = await collection
          .where('stb', isEqualTo: int.parse(stbC.text))
          .where('pass', isEqualTo: passC.text)
          .get();
      log("ada data");
      if (data.size == 0) {
        log("akun belum terdaftar");
        final mhs = response.body['data'][0];
        final dataMhs = PemilihModel(
          stb: mhs['stb'],
          nama: mhs['nmmhs'],
          pass: passC.text,
          isMemilih: false,
          isAktif: true,
        ).toMap();
        if (sessionLoginC.text == 'Mahasiswa') {
          log("add data mahasiswa");
          methodApp.addPemilih(data: dataMhs);
        } else {
          log("add data capres");
          methodApp.addCapres(data: dataMhs);
        }
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("sesiLogin", sesiLogin);
      Get.offAllNamed(
        Routes.DASHBOARD,
      );
      // return;
    } else {
      alertGagal();
    }
  }

  alertGagal() {
    alertActions(
      'Info',
      'anda tidak terdaftar',
      [
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          onPressed: () {
            Get.back(result: false);
            // Get.back();
          },
        ),
      ],
    );
  }
}
