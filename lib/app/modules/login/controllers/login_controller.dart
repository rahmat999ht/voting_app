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
import '../components/alert_value_form.dart';

class LoginController extends GetxController {
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
          await iniData(pemilih, 'pemilih');
        } else {
          final capres = ConstansApp.firestore.collection(
            ConstansApp.capresCollection,
          );
          await iniData(capres, 'capres');
        }
      }
    } catch (e) {
      alertInfo('info', 'pesan error : $e');
    }
    initLoading();
  }

  Future iniData(
    CollectionReference<Map<String, dynamic>> collection,
    String sesiLogin,
  ) async {
    final data = await collection
        .where('stb', isEqualTo: int.parse(stbC.text))
        .where('pass', isEqualTo: passC.text)
        .get();
    if (data.size == 0) {
      log("data 0");
      alertGagal();
      return;
    } else {
      log("try : ${data.docs.first.id}");
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("sesiLogin", sesiLogin);
      prefs.setString("idLogin", data.docs.first.id);
      Get.offAllNamed(
        Routes.DASHBOARD,
      );
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

  @override
  void onInit() async {
    const stbNumber = 192581; // Ganti dengan nilai yang sesuai
    final response = await userProvider.getUser(stbNumber);
    if (response.statusCode == 200) {
      log('Data berhasil diambil: ${response.body}');
    } else {
      log('Gagal mengambil data. Status code: ${response.statusCode}');
    }
    super.onInit();
  }
}
