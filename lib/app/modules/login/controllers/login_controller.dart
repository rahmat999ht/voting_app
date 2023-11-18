import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/app/core/interface/alerts/alert_info.dart';
import 'package:voting_app/app/routes/app_pages.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_actions.dart';
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
    final data = await collection
        .where('stb', isEqualTo: int.parse(stbC.text))
        .where('pass', isEqualTo: passC.text)
        .get();
    final response = await userProvider.getUser(
      int.parse(stbC.text),
      int.parse(passC.text),
    );
    if (response.statusCode == 200) {
      log("ada data");
      if (data.size == 0) {
        final mhs = response.body['data'][0];
        final dataMhs = {
          "stb": mhs['stb'],
          "nmmhs": mhs['nmmhs'],
          "alm": mhs['alm'],
          "email": mhs['email'],
          "nohp": mhs['nohp'],
        };
        if (sessionLoginC.text == 'Mahasiswa') {
          methodApp.addPemilih(data: dataMhs);
        } else {
          methodApp.addCapres(data: dataMhs);
        }
      }
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("sesiLogin", sesiLogin);
      Get.offAllNamed(
        Routes.DASHBOARD,
      );
      return;
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
