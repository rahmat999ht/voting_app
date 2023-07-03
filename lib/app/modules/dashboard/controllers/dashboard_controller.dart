import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:voting_app/app/modules/hasil/views/hasil_view.dart';
import 'package:voting_app/app/modules/home/views/home_view.dart';
import 'package:voting_app/app/modules/pemilihan/views/pemilihan_view.dart';
import 'package:voting_app/app/modules/profile/views/profile_view.dart';

class DashboardController extends GetxController {
  final selectedIndex = 0.obs;
  List<Widget> widgetOptions() => [
        const HomeView(),
        const PemilihanView(),
        const HasilView(),
        const ProfileView(),
      ];
  @override
  void onInit() {
    selectedIndex.value = 0;
    super.onInit();
  }
}
