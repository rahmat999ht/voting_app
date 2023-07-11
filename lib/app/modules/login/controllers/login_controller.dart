import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/app/core/interface/alerts/alert_info.dart';
import 'package:voting_app/app/routes/app_pages.dart';

import '../../../core/constans/constans_app.dart';
import '../../../core/interface/alerts/alert_actions.dart';
import '../components/alert_value_form.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final stbC = TextEditingController();
  final passC = TextEditingController();
  final sessionLoginC = TextEditingController();
  final isLoading = false.obs;
  final isObscure = true.obs;

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
          await iniData(pemilih, true);
        } else {
          final capres = ConstansApp.firestore.collection(
            ConstansApp.capresCollection,
          );
          await iniData(capres, false);
        }
      }
    } catch (e) {
      alertInfo('info', 'pesan error : $e');
    }
    initLoading();
  }

  Future iniData(
    CollectionReference<Map<String, dynamic>> collection,
    bool sesiIsPemilih,
  ) async {
    final data = await collection
        .where('stb', isEqualTo: int.parse(stbC.text))
        .where('pass', isEqualTo: passC.text)
        .get();
    if (data.size == 0) {
      log("data 0");
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
      return;
    } else {
      log("try : ${data.docs.first.id}");
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("sesiLogin", sesiIsPemilih);
      prefs.setString("idLogin", data.docs.first.id);
      Get.offAllNamed(
        Routes.DASHBOARD,
      );
    }
  }

  // final List<Map<String, dynamic>> pemilih = [
  //   {
  //     "stb": "900943979",
  //     "nama": "Mr. Carolyn Lehner",
  //     "jkl": "Demi-girl",
  //     "pass": "eI3dHUn1G7DsgJZ",
  //     "isMemilih": true,
  //     "isAktif": true,
  //     "prody": "prody 1",
  //     "id": "1"
  //   },
  //   {
  //     "stb": "687002832",
  //     "nama": "Sarah Weimann",
  //     "jkl": "Transgender female",
  //     "pass": "b9qRYRfhz4cL9K9",
  //     "isMemilih": false,
  //     "isAktif": false,
  //     "prody": "prody 2",
  //     "id": "2"
  //   },
  //   {
  //     "stb": "959030707",
  //     "nama": "Pearl Rempel",
  //     "jkl": "Trans woman",
  //     "pass": "muErOrIM8lRvnyg",
  //     "isMemilih": false,
  //     "isAktif": true,
  //     "prody": "prody 3",
  //     "id": "3"
  //   },
  //   {
  //     "stb": "726506862",
  //     "nama": "Doug Ondricka",
  //     "jkl": "Demi-man",
  //     "pass": "Xra1uByiADr9EYa",
  //     "isMemilih": true,
  //     "isAktif": true,
  //     "prody": "prody 4",
  //     "id": "4"
  //   },
  //   {
  //     "stb": "970244954",
  //     "nama": "Dr. Cynthia Powlowski",
  //     "jkl": "Demigender",
  //     "pass": "11awohp6S1rnkRE",
  //     "isMemilih": false,
  //     "isAktif": true,
  //     "prody": "prody 5",
  //     "id": "5"
  //   },
  //   {
  //     "stb": "737179550",
  //     "nama": "Larry Pacocha Jr.",
  //     "jkl": "Androgyne",
  //     "pass": "YN_ObdBW7_DMRv_",
  //     "isMemilih": true,
  //     "isAktif": true,
  //     "prody": "prody 6",
  //     "id": "6"
  //   },
  //   {
  //     "stb": "279569550",
  //     "nama": "Angel Haag",
  //     "jkl": "T* man",
  //     "pass": "ew8Oq0evlxdBKr8",
  //     "isMemilih": true,
  //     "isAktif": false,
  //     "prody": "prody 7",
  //     "id": "7"
  //   },
  //   {
  //     "stb": "975114872",
  //     "nama": "Lance Schmidt",
  //     "jkl": "FTM",
  //     "pass": "bl7GqecpnjkEKqX",
  //     "isMemilih": true,
  //     "isAktif": true,
  //     "prody": "prody 8",
  //     "id": "8"
  //   },
  //   {
  //     "stb": "338268776",
  //     "nama": "Jill Auer",
  //     "jkl": "T* man",
  //     "pass": "pibcFH_6_KWQy9U",
  //     "isMemilih": false,
  //     "isAktif": false,
  //     "prody": "prody 9",
  //     "id": "9"
  //   },
  //   {
  //     "stb": "175208795",
  //     "nama": "Mr. Kelly Donnelly",
  //     "jkl": "Gender neutral",
  //     "pass": "Cv6VTcPEKZPplC9",
  //     "isMemilih": false,
  //     "isAktif": false,
  //     "prody": "prody 10",
  //     "id": "10"
  //   },
  //   {
  //     "stb": "013231303",
  //     "nama": "Casey Daniel Sr.",
  //     "jkl": "FTM",
  //     "pass": "NekHkpGyLcg1owr",
  //     "isMemilih": true,
  //     "isAktif": true,
  //     "prody": "prody 11",
  //     "id": "11"
  //   },
  //   {
  //     "stb": "940809374",
  //     "nama": "Edward Moore",
  //     "jkl": "Transexual",
  //     "pass": "3YpzW0rCo0GW2NK",
  //     "isMemilih": true,
  //     "isAktif": false,
  //     "prody": "prody 12",
  //     "id": "12"
  //   },
  //   {
  //     "stb": "837742007",
  //     "nama": "Bruce Dickens",
  //     "jkl": "Trans female",
  //     "pass": "0DtzBOHTsBWBjak",
  //     "isMemilih": false,
  //     "isAktif": true,
  //     "prody": "prody 13",
  //     "id": "13"
  //   },
  //   {
  //     "stb": "241826687",
  //     "nama": "Kara Reilly",
  //     "jkl": "Cis man",
  //     "pass": "ExPfk9HH6nvXu0Y",
  //     "isMemilih": true,
  //     "isAktif": false,
  //     "prody": "prody 14",
  //     "id": "14"
  //   },
  //   {
  //     "stb": "105322845",
  //     "nama": "Mr. Matthew Spencer II",
  //     "jkl": "Hermaphrodite",
  //     "pass": "FnicqQ6Y0CqClWm",
  //     "isMemilih": false,
  //     "isAktif": false,
  //     "prody": "prody 15",
  //     "id": "15"
  //   },
  //   {
  //     "stb": "910181624",
  //     "nama": "Manuel Pacocha",
  //     "jkl": "Demi-girl",
  //     "pass": "GBm77liEJuvg8Bg",
  //     "isMemilih": false,
  //     "isAktif": true,
  //     "prody": "prody 16",
  //     "id": "16"
  //   },
  //   {
  //     "stb": "222595814",
  //     "nama": "Frank Grady",
  //     "jkl": "Androgyne",
  //     "pass": "J4AAHjVJ1OLqXb9",
  //     "isMemilih": true,
  //     "isAktif": true,
  //     "prody": "prody 17",
  //     "id": "17"
  //   },
  //   {
  //     "stb": "911874150",
  //     "nama": "Kerry Aufderhar",
  //     "jkl": "Demi-boy",
  //     "pass": "iO4RTvpozab2liM",
  //     "isMemilih": true,
  //     "isAktif": true,
  //     "prody": "prody 18",
  //     "id": "18"
  //   },
  //   {
  //     "stb": "354147091",
  //     "nama": "Mrs. Melody Casper",
  //     "jkl": "Transmasculine",
  //     "pass": "AQnsY_js07qz1nc",
  //     "isMemilih": false,
  //     "isAktif": false,
  //     "prody": "prody 19",
  //     "id": "19"
  //   },
  //   {
  //     "stb": "055560032",
  //     "nama": "Jean Gleichner",
  //     "jkl": "Omnigender",
  //     "pass": "bwyPFqhdEICUZYN",
  //     "isMemilih": false,
  //     "isAktif": true,
  //     "prody": "prody 20",
  //     "id": "20"
  //   }
  // ];

  // void addDataCapres() {
  //   initLoading();
  //   for (int i = 0; i < pemilih.length; i++) {
  //     final instantSTB = i + 9 * i + i;
  //     final initSTB = instantSTB.toString().padLeft(3, '0');
  //     final stbSI = int.parse('191$initSTB');
  //     final stbTI = int.parse('192$initSTB');
  //     final passSI = 'm191$initSTB';
  //     final passTI = 'm192$initSTB';
  //     log('stb : $passTI');
  //     ConstansApp.firestore.collection(ConstansApp.pemilihCollection).add(
  //           PemilihModel(
  //             stb: i % 2 == 1 ? stbSI : stbTI,
  //             nama: pemilih[i]['nama'],
  //             jkl: i % 2 == 1 ? 'Laki-Laki' : 'Perempuan',
  //             prody: i % 2 == 1 ? 'Sistem Imformasi' : 'Teknik Informatika',
  //             pass: i % 2 == 1 ? passSI : passTI,
  //             isMemilih: false,
  //             isAktif: true,
  //           ).toMap(),
  //         );
  //   }
  //   Get.snackbar('info', 'add data selesai');
  //   initLoading();
  // }
}
