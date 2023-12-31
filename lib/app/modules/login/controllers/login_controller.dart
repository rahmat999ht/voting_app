import 'dart:convert';
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
        final body = response.body;
        final map = json.decode(body);
        final mhs = map['data'][0];

        log(body.toString(), name: 'body');
        log(map.toString(), name: 'map');
        log(mhs.toString(), name: 'mhs');
        final dataMhs = PemilihModel(
          stb: int.parse(mhs['stb']),
          nama: mhs['nmmhs'],
          pass: passC.text,
          isMemilih: false,
          isAktif: true,
        ).toMap();
        if (sessionLoginC.text == 'Mahasiswa') {
          log("add data mahasiswa");
          final docRef = await methodApp.addPemilih(data: dataMhs);
          await toDasboard(sesiLogin, docRef.id);
        } else {
          alertGagal('Akun anda tidak terdaftar sebagai capres');
          // methodApp.addCapres(data: dataMhs);
        }
      } else {
        String documentId = data.docs.first.id;
        log(documentId);
        toDasboard(sesiLogin, documentId);
      }
    } else {
      alertGagal('anda tidak terdaftar di siaka');
    }
  }

  Future toDasboard(String session, String idLogin) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("sesiLogin", session);
    prefs.setString("idLogin", idLogin);
    Get.offAllNamed(
      Routes.DASHBOARD,
    );
  }

  alertGagal(String message) {
    alertActions(
      'Info',
      message,
      // 'anda tidak terdaftar',
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
