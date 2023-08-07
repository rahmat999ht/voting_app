import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/app/core/models/capres.dart';
import 'package:voting_app/app/core/models/pemilih.dart';
import 'package:voting_app/app/modules/hasil/views/hasil_view.dart';
import 'package:voting_app/app/modules/home/views/home_view.dart';
import 'package:voting_app/app/modules/pemilihan/views/pemilihan_view.dart';
import 'package:voting_app/app/modules/profile/views/profile_view.dart';

import '../../../core/constans/constans_app.dart';

class DashboardController extends GetxController with StateMixin<dynamic> {
  final selectedIndex = 0.obs;
  bool? sesionLogin;
  List<Widget> widgetOptions() => [
        const HomeView(),
        const PemilihanView(),
        const HasilView(),
        const ProfileView(),
      ];
  String? idLoginUser;

  PemilihModel? pemilihModel;
  late final List<PemilihModel> dataPemilih;
  CapresModel? capresModel;
  late final List<CapresModel> dataCapres;

  @override
  void onInit() async {
    final prefs = await SharedPreferences.getInstance();

    final idLogin = prefs.getString('idLogin');
    log(idLogin!);
    final sesiLogin = prefs.getBool('sesiLogin');
    sesionLogin = sesiLogin ?? false;
    log(sesiLogin.toString());
    await initData(sesiLogin!, idLogin);
    selectedIndex.value = 0;
    super.onInit();
  }

  Future initData(bool sesiLogin, String idLogin) async {
    if (sesiLogin == true) {
      final dataAllUser = await ConstansApp.firestore
          .collection(ConstansApp.pemilihCollection)
          .get();
      dataPemilih = dataAllUser.docs
          .map((e) => PemilihModel.fromDocumentSnapshot(e))
          .toList();
      var dataUserModel = dataAllUser.docs.firstWhere((e) => e.id == idLogin);
      pemilihModel = PemilihModel.fromDocumentSnapshot(dataUserModel);
      idLoginUser = capresModel!.id;
      successState(pemilihModel!);
    } else {
      final dataAllUser = await ConstansApp.firestore
          .collection(ConstansApp.capresCollection)
          .get();
      dataCapres = dataAllUser.docs
          .map((e) => CapresModel.fromDocumentSnapshot(e))
          .toList();
      var dataUserModel = dataAllUser.docs.firstWhere((e) => e.id == idLogin);
      capresModel = CapresModel.fromDocumentSnapshot(dataUserModel);
      idLoginUser = capresModel!.id;
      successState(capresModel!);
    }
  }

  void loadingState() {
    change(
      null,
      status: RxStatus.loading(),
    );
  }

  void successState(dynamic userLogin) {
    change(
      userLogin,
      status: RxStatus.success(),
    );
  }
}
